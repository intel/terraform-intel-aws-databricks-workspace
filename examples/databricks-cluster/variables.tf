variable "region" {
  type = string
  description = "AWS Region that will be used as a part of the deployment"
  default     = "us-east-2"
}

variable "dbx_host" {
  type = string
  description = "Required URL for the databricks workspace"
}

variable "dbx_account_password" {
  type = string
  description = "Account Login Password for the Databricks Account"
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username/Email for the Databricks Account"
}

variable "dbx_account_id" {
  type = string
  description = "Account ID Number for the Databricks Account"
}

