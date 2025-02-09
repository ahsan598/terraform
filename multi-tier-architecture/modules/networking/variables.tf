variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed for HTTP access"
  type        = list(string)
}