#This example creates an AWS databricks workspace with the default Credentials, Storage and Network Configurations and Databricks Cluster with Intel Optimizations. For more information on usage configuration, use the README.md
module "aws_databricks_workspace" {
  source               = "intel/aws-databricks-workspace/intel"
  vpc_id               = var.vpc_id
  dbx_account_id       = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids       = var.vpc_subnet_ids
  security_group_ids   = var.security_group_ids
}

# This module example creates databricks cluster on an your AWS dbx workspace created above.
module "databricks_cluster" {
  source    = "intel/databricks-cluster/intel"
  dbx_host  = module.aws_databricks_workspace.dbx_host
  dbx_cloud = var.dbx_cloud
  providers = {
    databricks = databricks.cluster
  }
  depends_on = [
    module.aws_databricks_workspace
  ]
  tags = {
    "owner"  = "user@example.com"
    "module" = "Intel-Cloud-Optimization-Module"
  }
}