terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.9.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

provider "databricks" {
  host     = "https://accounts.cloud.databricks.com"
  username = var.dbx_account_username
  password = var.dbx_account_password
}

// Initialize the Databricks provider in "normal" (workspace) mode.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "workspace"
  host     = databricks_mws_workspaces.ws.workspace_url
  username = var.dbx_account_username
  password = var.dbx_account_password
}
