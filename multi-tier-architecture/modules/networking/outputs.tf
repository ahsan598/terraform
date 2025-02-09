output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.multi_tier_vpc.id
}

output "public_subnets_id" {
  description = "Public Subnet IDs"
  value       = aws_subnet.multi_tier_public_subnet[*].id
}

output "private_subnets_id" {
  description = "Private Subnet IDs"
  value       = aws_subnet.multi_tier_private_subnet[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.multi_tier_igw.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.multi_tier_nat.id
}


output "web_security_group_id" {
  description = "Security Group ID for web servers"
  value       = aws_security_group.multi_tier_websg.id
}

output "app_security_group_id" {
  description = "Security Group ID for application servers"
  value       = aws_security_group.multi_tier_appsg.id
}