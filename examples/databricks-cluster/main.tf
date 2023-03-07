# This example creates databricks cluster on an existing dbx workspace. URL for the workspace must be provided
module "databricks_workspace" {
  source = "../../created_workspace"
  providers = {
    databricks = databricks.workspace
  }
}

