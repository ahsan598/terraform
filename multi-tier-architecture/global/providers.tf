provider "aws" {
  region = var.aws_region

  # Optionally assume a role if required
  # assume_role {
  #   role_arn = var.aws_role_arn
  # }
  
}