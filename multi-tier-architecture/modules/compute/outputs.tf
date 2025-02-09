output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.multi_tier_asg.id
}

output "tg_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.multi_tier_tg.arn
}