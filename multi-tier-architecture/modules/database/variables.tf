variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Security Group ID for application servers"
  type        = string
}

variable "db_engine" {
  description = "Database engine (mysql, postgres, etc.)"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
}

variable "db_storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
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

variable "db_parameter_group" {
  description = "DB parameter group"
  type        = string
}

variable "db_port" {
  description = "Port for database access"
  type        = number
}