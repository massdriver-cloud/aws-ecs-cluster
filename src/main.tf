locals {
  vpc_id             = element(split("/", var.vpc.data.infrastructure.arn), 1)
  public_subnet_ids  = toset([for subnet in var.vpc.data.infrastructure.public_subnets : element(split("/", subnet["arn"]), 1)])
  private_subnet_ids = toset([for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)])

  # Note that we aren't referencing the aws_ecs_capacity_provider.ec2 resource. Normally we would as this dependency is real and important,
  # however it breaks during updates if an aws_ecs_capacity_provider is deleted (https://github.com/hashicorp/terraform-provider-aws/issues/29152)
  # The current workaround is to remove this dependency and hack around it using a time_sleep.
  capacity_providers = distinct(concat(
    #[for key, value in aws_ecs_capacity_provider.ec2 : value.name],     <-- This is how it should be if not for the issue ^
    [for instance in var.cluster.instances : "${var.md_metadata.name_prefix}-${instance.name}"],
    ["FARGATE",
    "FARGATE_SPOT"]
  ))
}

resource "aws_ecs_cluster" "main" {
  name = var.md_metadata.name_prefix

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = local.capacity_providers
  depends_on         = [time_sleep.asg_provision_wait]
}

# Since we can't use the normal dependency tree to have the aws_ecs_cluster_capacity_providers resource update after the ASG
# is created, we instead need to "wait" whenever an ASG is made until after it is provisioned. Usually this takes 1-2 minutes.
# To be safe we are setting it to 10m. This only occurs when a new ASG is created. This is a workaround until (if??) a fix
# is implemented for https://github.com/hashicorp/terraform-provider-aws/issues/29152
resource "time_sleep" "asg_provision_wait" {
  for_each        = { for instance in var.cluster.instances : instance.name => instance }
  create_duration = "10m"
}
