#This example creates an databricks workspace with the non-default Credentials, Storage and Network Configurations (Steps 3 and 4 Included). For more information on usage configuration, use the README.md
module "databricks_workspace" {
  source               = "intel/aws-databricks/intel"
  vpc_id               = var.vpc_id
  dbx_account_id       = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids       = var.vpc_subnet_ids
  security_group_ids   = var.security_group_ids

  ##Storage Config
  create_bucket = false
  bucket_name   = "shreejan-dbx-bucket"

  ##Credential Config
  create_aws_account_role     = false
  aws_cross_account_role_name = "shreejan-dbx"
  aws_cross_account_arn       = "arn:aws:iam::499974397304:role/shreejan-dbx"
}
