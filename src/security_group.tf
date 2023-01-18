
resource "aws_security_group" "ec2" {
  vpc_id      = local.vpc_id
  name        = var.md_metadata.name_prefix
  description = "ECS cluster ${var.md_metadata.name_prefix} EC2 instance security group"

  tags = merge(
    var.md_metadata.default_tags,
    {
      Name = var.md_metadata.name_prefix
    }
  )
}

resource "aws_security_group_rule" "ecs_internal_ingress" {
  description = "Cluster internal ingress"

  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  self      = true

  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ecs_all_egress" {
  description = "Allow all egress"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2.id
}
