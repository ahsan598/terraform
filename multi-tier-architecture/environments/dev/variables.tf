variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the web application"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for compute instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "db_instance_class" {
  description = "Database instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage for the database"
  type        = number
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ssl_certificate_arn" {
  description = "ARN of SSL Certificate for Load Balancer"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name"
  type        = string
}

variable "create_hosted_zone" {
  description = "Set to true if a new hosted zone is required"
  type        = bool
  default     = false
}

variable "existing_zone_id" {
  description = "Existing Route 53 Hosted Zone ID (if not creating a new one)"
  type        = string
  default     = ""
}