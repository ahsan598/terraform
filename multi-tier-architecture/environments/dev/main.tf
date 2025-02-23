# Load Networking Module
module "networking" {
  source               = "../../modules/networking"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  allowed_cidrs        = var.allowed_cidrs
  azs                  = var.azs
}

# Load Compute Module
module "compute" {
  source        = "../../modules/compute"
  project_name  = var.project_name
  instance_type = var.instance_type
  ami_id        = var.ami_id
  subnet_ids    = module.networking.public_subnet_ids
}

# Load Database Module
module "database" {
  source              = "../../modules/database"
  project_name        = var.project_name
  db_instance_class   = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  subnet_ids          = module.networking.private_subnet_ids
}

# Load Load Balancer Module
module "load_balancer" {
  source              = "../../modules/load_balancer"
  project_name        = var.project_name
  vpc_id              = module.networking.vpc_id
  public_subnet_ids   = module.networking.public_subnets
  web_instance_ids    = module.compute.web_instance_ids
  ssl_certificate_arn = var.ssl_certificate_arn
}

# Load DNS Module
module "dns" {
  source              = "../../modules/dns"
  project_name        = var.project_name
  domain_name         = var.domain_name
  create_hosted_zone  = var.create_hosted_zone
  existing_zone_id    = var.existing_zone_id
  alb_dns_name        = module.load_balancer.alb_dns_name
  alb_zone_id         = module.load_balancer.alb_zone_id
} 