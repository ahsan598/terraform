# Compute Module

This module provisions:
- Launch Template for EC2 instances
- Auto Scaling Group (ASG)
- Application Load Balancer (ALB)
- Security Groups for ALB and ASG

## Usage
```hcl
module "compute" {
  source                = "../../modules/compute"
  project_name          = "my-app"
  ami_id                = "ami-0abcdef1234567890"
  instance_type         = "t3.micro"
  asg_min_size          = 2
  asg_max_size          = 4
  asg_desired_capacity  = 2
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnets
  private_subnet_ids    = module.networking.private_subnets
  app_sg_id             = module.networking.app_security_group_id
}