#This example creates an databricks workspace with the non-default Credentials, Storage and Network Configurations (Steps 3 and 4 Included). For more information on usage configuration, use the README.md
module "databricks_workspace" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]

  ##Storage Config
  create_bucket = false
  bucket_name = "shreejan-dbx-bucket"

  ##Credential Config
  create_aws_account_role = false
  aws_cross_account_role_name = "shreejan-dbx"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/shreejan-dbx"
}
