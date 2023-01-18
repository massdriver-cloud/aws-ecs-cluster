
locals {
  user_data = <<EOT
#!/bin/bash
echo ECS_CLUSTER="${var.md_metadata.name_prefix}" >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_POLL_METRICS=true >> /etc/ecs/ecs.config
EOT
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "main" {
  for_each = { for instance in var.cluster.instances : instance.name => instance }

  name_prefix   = "${var.md_metadata.name_prefix}-${each.key}"
  user_data     = base64encode(local.user_data)
  instance_type = each.value.instance_type
  image_id      = data.aws_ssm_parameter.ami.value

  disable_api_termination = false
  ebs_optimized           = false
  update_default_version  = true

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance.arn
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    description                 = "${var.md_metadata.name_prefix}-${each.key} network interface"
    device_index                = 0
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = toset([aws_security_group.ec2.id])
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    http_protocol_ipv6          = "disabled"
    instance_metadata_tags      = "disabled"
  }

  dynamic "tag_specifications" {
    for_each = toset(["instance", "volume"])
    content {
      resource_type = tag_specifications.key
      tags = merge({
        AmazonECSManaged = true
        Name             = "${var.md_metadata.name_prefix}-${each.key}"
        },
        var.md_metadata.default_tags,
      )
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_capacity_provider" "ec2" {
  for_each = { for instance in var.cluster.instances : instance.name => instance }
  name     = "${var.md_metadata.name_prefix}-${each.key}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ec2[each.key].arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      // default values for all of these
      instance_warmup_period    = 300
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_autoscaling_group" "ec2" {
  for_each = { for instance in var.cluster.instances : instance.name => instance }

  name = "${var.md_metadata.name_prefix}-${each.key}"

  min_size = each.value.min_size
  max_size = each.value.max_size

  // default values for all of these
  default_cooldown          = 300
  force_delete              = false
  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["Default"]
  metrics_granularity       = "1Minute"

  # The Auto Scaling group must have instance protection from scale in enabled to use managed termination protection for a capacity provider,
  protect_from_scale_in = true

  launch_template {
    id      = aws_launch_template.main[each.key].id
    version = "$Latest"
  }

  vpc_zone_identifier = toset(
    [for subnet in var.vpc.data.infrastructure.private_subnets : split("/", subnet.arn)[1]]
  )

  dynamic "tag" {
    for_each = merge({
      AmazonECSManaged = true
      Name             = "${var.md_metadata.name_prefix}-${each.key}"
      },
      var.md_metadata.default_tags,
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}
