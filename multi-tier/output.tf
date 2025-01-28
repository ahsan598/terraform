output "elb_dns_name" {
  value = aws_elb.web_elb.dns_name
}

output "db_instance_address" {
  value = aws_db_instance.app_db.address
}