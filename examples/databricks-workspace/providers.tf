provider "aws" {
  region = var.region
}

provider "databricks" {
  host     = "https://accounts.cloud.databricks.com"
  username = "shreejan.mistry@intel.com"
  password = "Blackdown2112!"
}

// Initialize the Databricks provider in "normal" (workspace) mode.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "workspace"
  host     = module.databricks_setup.databricks_host
  username = "shreejan.mistry@intel.com"
  password = "Blackdown2112!"
}
