variable "vpc_cidr_block" {
  type = string
  description = "CIDR block for the VPC in dev"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
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