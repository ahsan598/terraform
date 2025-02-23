#!/bin/bash
set -e  # Exit on error

echo "Initializing Terraform..."
terraform init -backend-config=../backend.tf

echo "Formatting Terraform files..."
terraform fmt -recursive

echo "Validating Terraform configuration..."
terraform validate

echo "Terraform initialization completed!"