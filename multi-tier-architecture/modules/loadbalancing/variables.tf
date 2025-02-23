variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "web_instance_ids" {
  description = "List of Web Server Instance IDs"
  type        = list(string)
}

variable "ssl_certificate_arn" {
  description = "ARN of SSL Certificate for HTTPS Listener"
  type        = string
}
