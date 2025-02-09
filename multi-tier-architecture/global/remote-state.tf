terraform {
  backend "s3" {
    bucket = "my-tf-state-bucket"
    key    = "terraform/state"
    region = "us-east-1"
  }
}