variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}