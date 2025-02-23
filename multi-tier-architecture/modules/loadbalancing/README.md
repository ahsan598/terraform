# Load Balancer Module

This module provisions:
- An Application Load Balancer (ALB)
- A security group for the ALB
- Target Group for web servers
- HTTP and HTTPS listeners

## Usage
```hcl
module "load_balancer" {
  source              = "../../modules/load_balancer"
  project_name        = "my-app"
  vpc_id              = module.networking.vpc_id
  public_subnet_ids   = module.networking.public_subnets
  web_instance_ids    = module.compute.web_instance_ids
  ssl_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxxxxxx"
}