provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source          = "./dev/modules/ec2"
  instance_name   = var.instance_name
  ami_id          = var.ami_id
  instance_type   = var.instance_type
}