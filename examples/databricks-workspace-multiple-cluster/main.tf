#This example creates an databricks workspace with the default Credentials, Storage and Network Configurations and Multiple Databricks Cluster with Intel Optimizations. For more information on usage configuration, use the README.md
module "databricks_workspace" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
}
module "databricks_cluster" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.databricks_workspace
  ]
  #REMOVE THIS
  tags = {
    "owner" = "shreejan.mistry@intel.com"
    "duration" = "4"
  }
}

module "databricks_cluster_2" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.databricks_workspace
  ]
  dbx_cluster_name = "dbx_optimized_cluster_2"
  #REMOVE THIS
  tags = {
    "owner" = "shreejan.mistry@intel.com"
    "duration" = "4"
  }
}