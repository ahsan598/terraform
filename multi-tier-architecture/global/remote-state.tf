terraform {
  backend "s3" {
    bucket         = "my-terraform-backend"
    key            = "modular-web-app/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}