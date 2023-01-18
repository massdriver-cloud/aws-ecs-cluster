locals {
  vpc_id             = element(split("/", var.vpc.data.infrastructure.arn), 1)
  public_subnet_ids  = toset([for subnet in var.vpc.data.infrastructure.public_subnets : element(split("/", subnet["arn"]), 1)])
  private_subnet_ids = toset([for subnet in var.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)])
  capacity_providers = distinct(concat(
    [for key, value in aws_ecs_capacity_provider.ec2 : value.name],
    ["FARGATE",
    "FARGATE_SPOT"]
  ))
  # default_capacity_strategy = [
  #   for name, weight in var.default_capacity_strategy.weights : {
  #     capacity_provider = name,
  #     weight            = weight,
  #     base              = var.default_capacity_strategy.base.provider == name ? var.default_capacity_strategy.base.value : null
  #   }
  # ]
}

resource "aws_ecs_cluster" "main" {
  name = var.md_metadata.name_prefix

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  # configuration {
  #   execute_command_configuration {
  #     kms_key_id = var.kms_key_id
  #     logging    = var.logging
  #     dynamic "log_configuration" {
  #       for_each = var.logging == "OVERRIDE" ? [var.log_configuration] : []
  #       content {
  #         cloud_watch_encryption_enabled = log_configuration.value["cloud_watch_encryption_enabled"]
  #         cloud_watch_log_group_name     = log_configuration.value["cloud_watch_log_group_name"]
  #         s3_bucket_name                 = log_configuration.value["s3_bucket_name"]
  #         s3_bucket_encryption_enabled   = true
  #         s3_key_prefix                  = log_configuration.value["s3_key_prefix"]
  #       }
  #     }
  #   }
  # }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = local.capacity_providers

  # dynamic "default_capacity_provider_strategy" {
  #   for_each = local.default_capacity_strategy
  #   content {
  #     base              = default_capacity_provider_strategy.value["base"]
  #     weight            = default_capacity_provider_strategy.value["weight"]
  #     capacity_provider = default_capacity_provider_strategy.value["capacity_provider"]
  #   }
  # }
}
