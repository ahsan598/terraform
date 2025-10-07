# Terraform

This repository contains basic terraform configurations along with commonly used commands and a `Makefile` to simplify workflow automation.
It provides an easy starting point for managing infrastructure as code — including environment setup, initialization, validation, planning, and applying Terraform configurations through make commands.

---

### Basic Commands:

- **Initialize Terraform:**
  `terraform init`

- **Validate Configuration:**
  `terraform validate`

- **Plan Infrastructure Changes:**
  `terraform plan`

- **Apply Infrastructure Changes:**
  `terraform apply`

- **Destroy Infrastructure:**
  `terraform destroy`

### Workspace Management:

- **Create a New Workspace:**
  `terraform workspace new <workspace-name>`

- **List Workspaces:**
  `terraform workspace list`

- **Show Workspaces:**
  `terraform workspace show`

- **Select a Workspace:**
  `terraform workspace select <workspace-name>`

- **Delete a Workspace:**
  `terraform workspace delete <workspace-name>`

### State Management:

- **Show State:**
  `terraform show`

- **List Resources in State:**
  `terraform state list`

- **Move a Resource in State:**
  `terraform state mv <source> <destination>`

- **Remove a Resource from State:**
  `terraform state rm <resource>`

### Modules:

- **Get Modules:**
  `terraform get`

- **Update Modules:**
  `terraform get --update`

### Importing Resources:

- **Import Existing Infrastructure:**
  `terraform import <resource_type>.<resource_name> <id>`

### Output Management:

- **Show Outputs:**
  `terraform output`

- **Refresh Outputs:**
  `terraform refresh`

### Formatting and Linting:

- **Format Configuration:**
  `terraform fmt`

- **Generate Documentation:**
  `terraform-docs markdown .`