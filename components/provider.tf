provider "azurerm" {
  features {}
}

provider "github" {
  owner = ""
  token = var.oauth_token
}

terraform {
  required_version = ">= 1.5.7"

  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
    use_oidc             = true
    use_azuread_auth     = true
  }
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}