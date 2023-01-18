locals {
  create_alb                  = var.cluster.ingress.enable_ingress
  default_route53_zone_id     = local.create_alb ? element(split("/", var.cluster.ingress.default_route53_hosted_zone), 1) : ""
  additional_route53_zone_ids = local.create_alb ? toset([for zone_arn in var.cluster.ingress.additional_route53_hosted_zones : element(split("/", zone_arn), 1)]) : toset([])
  all_route53_zone_ids        = local.create_alb ? toset(concat([local.default_route53_zone_id], tolist(local.additional_route53_zone_ids))) : toset([])
  r53_zone_ids_to_domains     = { for zid in local.all_route53_zone_ids : zid => data.aws_route53_zone.lookup[zid].name }
  r53_domains_to_zone_ids     = { for zid in local.all_route53_zone_ids : data.aws_route53_zone.lookup[zid].name => zid }
}

resource "aws_security_group" "alb" {
  count       = local.create_alb ? 1 : 0
  vpc_id      = local.vpc_id
  name        = "${var.md_metadata.name_prefix}-alb"
  description = "ECS cluster ${var.md_metadata.name_prefix} ALB security group"

  tags = merge(
    var.md_metadata.default_tags,
    {
      Name = "${var.md_metadata.name_prefix}-alb"
    }
  )
}

resource "aws_security_group_rule" "alb_http_ingress" {
  count       = local.create_alb ? 1 : 0
  description = "HTTP ingress"

  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.0.id
}

resource "aws_security_group_rule" "alb_https_ingress" {
  count       = local.create_alb ? 1 : 0
  description = "HTTPS ingress"

  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.0.id
}

resource "aws_security_group_rule" "alb_all_egress" {
  count       = local.create_alb ? 1 : 0
  description = "Allow all egress"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.0.id
}

resource "aws_lb" "main" {
  count              = local.create_alb ? 1 : 0
  name               = var.md_metadata.name_prefix
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.0.id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false
}

// Certificates
module "default_acm_certificate" {
  count                     = local.create_alb ? 1 : 0
  source                    = "github.com/massdriver-cloud/terraform-modules//aws/acm-certificate?ref=21b84cd"
  domain_name               = local.r53_zone_ids_to_domains[local.default_route53_zone_id]
  hosted_zone_id            = local.default_route53_zone_id
  subject_alternative_names = ["*.${local.r53_zone_ids_to_domains[local.default_route53_zone_id]}"]
}

module "additional_acm_certificates" {
  source                    = "github.com/massdriver-cloud/terraform-modules//aws/acm-certificate?ref=21b84cd"
  for_each                  = local.additional_route53_zone_ids
  domain_name               = local.r53_zone_ids_to_domains[each.key]
  hosted_zone_id            = each.key
  subject_alternative_names = ["*.${local.r53_zone_ids_to_domains[each.key]}"]
}

data "aws_route53_zone" "lookup" {
  for_each     = local.all_route53_zone_ids
  zone_id      = each.key
  private_zone = false
}

// Listeners
resource "aws_lb_listener" "redirect_http_to_https" {
  count             = local.create_alb ? 1 : 0
  load_balancer_arn = aws_lb.main.0.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = local.create_alb ? 1 : 0
  load_balancer_arn = aws_lb.main.0.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.default_acm_certificate[0].certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Path not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_certificate" "example" {
  for_each        = module.additional_acm_certificates
  listener_arn    = aws_lb_listener.https.0.arn
  certificate_arn = each.value.certificate_arn
}
