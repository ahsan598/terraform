# Route 53 Hosted Zone (Optional: Only if not using an existing one)
resource "aws_route53_zone" "main" {
  count = var.create_hosted_zone ? 1 : 0
  name  = var.domain_name

  tags = {
    Name = "${var.project_name}-hosted-zone"
  }
}

# DNS Record (A Record pointing to ALB)
resource "aws_route53_record" "alb_dns" {
  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.existing_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# CNAME Record (Optional: Redirecting to ALB)
resource "aws_route53_record" "cname" {
  count   = var.create_cname ? 1 : 0
  zone_id = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.existing_zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]
}