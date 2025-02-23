output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.db_instance.endpoint
}

output "db_security_group_id" {
  description = "Security Group ID for the database"
  value       = aws_security_group.db_sg.id
}