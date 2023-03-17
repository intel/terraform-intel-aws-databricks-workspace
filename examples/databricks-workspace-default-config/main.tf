#This example creates an databricks workspace with the default Credentials, Storage and Network Configurations. For more information on usage configuration, use the README.md
module "databricks_workspace" {
  source               = "intel/aws-databricks/intel"
  vpc_id               = var.vpc_id
  dbx_account_id       = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids       = var.vpc_subnet_ids
  security_group_ids   = var.security_group_ids
}
