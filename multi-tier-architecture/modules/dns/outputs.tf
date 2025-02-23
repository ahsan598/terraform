output "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID"
  value       = var.create_hosted_zone ? aws_route53_zone.main[0].zone_id : var.existing_zone_id
}

output "alb_dns_record" {
  description = "DNS Record for ALB"
  value       = aws_route53_record.alb_dns.name
}

output "cname_record" {
  description = "CNAME Record"
  value       = var.create_cname ? aws_route53_record.cname[0].name : null
}