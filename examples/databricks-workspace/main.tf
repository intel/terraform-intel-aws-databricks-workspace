
module "databricks_setup" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
  create_bucket = true
  create_aws_account_role = true
  # aws_cross_account_role_name = "dbx_test_cross_act"
  # aws_cross_account_arn = "arn:aws:iam::499974397304:role/test-cross-acct"
}


module "databricks_workspace" {
  source = "../../created_worksapce"
  depends_on = [
    module.databricks_setup
  ]
  providers = {
    databricks = databricks.workspace
  }
}

