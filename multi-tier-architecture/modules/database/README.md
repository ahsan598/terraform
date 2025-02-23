# Database Module

This module provisions:
- RDS Subnet Group
- Security Group for Database
- RDS Instance

## Usage
```hcl
module "database" {
  source              = "../../modules/database"
  project_name        = "my-app"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnets
  app_sg_id          = module.compute.app_sg_id
  db_engine          = "mysql"
  db_engine_version  = "8.0"
  db_instance_class  = "db.t3.micro"
  db_allocated_storage = 20
  db_storage_encrypted = true
  db_username        = "admin"
  db_password        = "securepassword"
  db_parameter_group = "default.mysql8.0"
  db_port           = 3306
}