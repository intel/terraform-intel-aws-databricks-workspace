provider "aws" {
  region = var.region
}

provider "databricks" {
  host     = "https://accounts.cloud.databricks.com"
  username = var.dbx_account_username
  password = var.dbx_account_password
}
