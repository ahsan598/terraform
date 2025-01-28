terraform {
  required_providers {
    github = {
        source = "integrations/github"
        version = "~> 6.0"
    }
  }
}


provider "github" {
  token = "<your_token>"
}


resource "github_repository" "repo" {
  name = "test01"
  description = "This repo is created through terraform"

  visibility = "public"
}