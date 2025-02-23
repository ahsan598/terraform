#!/bin/bash
set -e

ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

cd ../environments/$ENV

echo "Destroying Terraform resources for $ENV..."
terraform destroy -auto-approve -var-file=terraform.tfvars

echo "Environment $ENV destroyed!"