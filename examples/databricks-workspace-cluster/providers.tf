// Initialize the Databricks provider in "normal" (workspace) mode.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  host     = "https://accounts.cloud.databricks.com"
  username = var.dbx_account_username
  password = var.dbx_account_password
}

// Intializing the following provider is REQUIRED step in order to add the databricks_global_init_script and databricks_cluster resource to your Databricks Workspace
provider "databricks" {
  alias    = "cluster"
  host     = module.aws_databricks_workspace.dbx_host
  username = var.dbx_account_username
  password = var.dbx_account_password
}