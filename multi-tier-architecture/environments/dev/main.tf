module "networking" {
  source = "../../modules/networking"
  vpc_cidr      = var.vpc_cidr_block
  public_cidr   = var.public_subnet_cidrs
  private_cidr  = var.private_subnet_cidrs
  azs           = var.azs
  project_name  = var.project_name
}