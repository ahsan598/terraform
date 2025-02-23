#!/bin/bash
set -e

ENV=$1  # Environment name (e.g., dev, staging, prod)
if [ -z "$ENV" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

cd ../environments/$ENV

echo "Planning Terraform changes for $ENV..."
terraform plan -var-file=terraform.tfvars

echo "Applying Terraform changes for $ENV..."
terraform apply -auto-approve -var-file=terraform.tfvars

echo "Deployment successful for $ENV!"