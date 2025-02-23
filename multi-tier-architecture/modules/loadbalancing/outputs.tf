output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.alb.dns_name
}

output "alb_security_group_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  description = "Target Group ARN for web servers"
  value       = aws_lb_target_group.tg_web.arn
}
