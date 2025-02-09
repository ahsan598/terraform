# Networking Module

This module creates the networking infrastructure, including:
- VPC
- Public and Private Subnets
- Internet Gateway (IGW)
- NAT Gateway
- Route Tables and Associations
- Security Groups

## Usage
```hcl
module "networking" {
  source          = "../../modules/networking"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]
  project_name   = "my-app"
}