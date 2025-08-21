locals {
  capabilities_ingress_public = var.cluster.ingress.enable_ingress ? [{
    load_balancer_arn  = aws_lb.main.0.arn
    security_group_arn = aws_security_group.alb.0.arn
    listeners = [{
      arn      = aws_lb_listener.https.0.arn
      port     = aws_lb_listener.https.0.port
      protocol = lower(aws_lb_listener.https.0.protocol)
      domains = flatten([
        local.r53_zone_ids_to_domains[local.default_route53_zone_id],
        [for zone in local.additional_route53_zone_ids : local.r53_zone_ids_to_domains[zone]]
      ])
    }]
  }] : []
}

resource "massdriver_artifact" "cluster" {
  field = "cluster"
  name  = "ECS Cluster artifact for ${var.md_metadata.name_prefix}"
  artifact = jsonencode(
    {
      data = {
        capabilities = {
          ingress = local.capabilities_ingress_public
        }
        infrastructure = {
          arn = aws_ecs_cluster.main.arn
          vpc = var.vpc
        }
        security = {}
      }
      specs = {
        aws = {
          region = var.vpc.specs.aws.region
        }
      }
    }
  )
}
