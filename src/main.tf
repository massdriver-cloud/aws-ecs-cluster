locals {
  vpc_id             = element(split("/", var.vpc.data.infrastructure.arn), 1)
  public_subnet_ids  = toset([for subnet in var.vpc.data.infrastructure.public_subnets : element(split("/", subnet["arn"]), 1)])
  private_subnet_ids = toset([for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)])
  capacity_providers = distinct(concat(
    [for key, value in aws_ecs_capacity_provider.ec2 : value.name],
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
}
