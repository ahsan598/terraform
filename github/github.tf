terraform {
  required_providers {
    github = {
        source = "integrations/github"
        version = "~> 6.0"
    }
  }
}


provider "github" {
  token = "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"
}


resource "github_repository" "repo" {
  name = "test01"
  description = "This repo is created through terraform"

  visibility = "public"
}