terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.14.2"
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

// Intializing the following provider is REQUIRED step in order to add the databricks_global_init_script resource to your Databricks Workspace
provider "databricks" {
  alias    = "workspace"
  host     = databricks_mws_workspaces.ws.workspace_url
  username = var.dbx_account_username   
  password = var.dbx_account_password
}