# This example creates databricks cluster on an existing dbx workspace. URL for the dbx workspace must be provided when prompted
module "databricks_cluster" {
  source = "../../created_workspace"
  providers = {
    databricks = databricks.workspace
  }

  #REMOVE THIS
  tags = {
    "owner" = "shreejan.mistry@intel.com"
    "duration" = "4"
  }
}

