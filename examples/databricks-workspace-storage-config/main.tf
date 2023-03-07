#This example creates an databricks workspace with the default Credentials and Network Configurations. 
#This example uses create_bucket = true for Storage Configurations
#For more information on usage configuration, use the README.md

module "databricks_setup" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
  aws_cross_account_role_name = "dbx-cross-account-role"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/dbx-cross-account-role"

  #Storage Config
  create_bucket = true
}