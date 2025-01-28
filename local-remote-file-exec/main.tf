provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source          = "./modules/ec2"
  instance_name   = var.instance_name
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  private_key_path = var.private_key_path
}