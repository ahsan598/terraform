variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name"
  type        = string
}

variable "create_hosted_zone" {
  description = "Set to true if a new hosted zone is required"
  type        = bool
  default     = false
}

variable "existing_zone_id" {
  description = "Existing Route 53 Hosted Zone ID (if not creating a new one)"
  type        = string
  default     = ""
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}

variable "create_cname" {
  description = "Set to true if a CNAME record is required"
  type        = bool
  default     = false
}

variable "subdomain" {
  description = "Subdomain name for the CNAME record"
  type        = string
  default     = "www"
}