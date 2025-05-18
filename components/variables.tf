variable "oauth_token" {
  description = "OAUTH token to use for authentication."
  type        = string
  sensitive   = true
}

variable "override_action" {
  description = "The action to override"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location for the resources"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = ""
}

variable "env" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
  default     = ""
}

variable "product" {
  description = "The product name or identifier"
  type        = string
  default     = ""
}
