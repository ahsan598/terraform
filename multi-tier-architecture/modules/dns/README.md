# DNS Module (Route 53)

This module provisions:
- A Route 53 Hosted Zone (optional)
- A Record for ALB
- Optional CNAME for subdomains

## Usage
```hcl
module "dns" {
  source              = "../../modules/dns"
  project_name        = "my-app"
  domain_name         = "example.com"
  create_hosted_zone  = false
  existing_zone_id    = "Z1234567890"
  alb_dns_name        = module.load_balancer.alb_dns_name
  alb_zone_id         = module.load_balancer.alb_zone_id
  create_cname        = true
  subdomain           = "www"
}