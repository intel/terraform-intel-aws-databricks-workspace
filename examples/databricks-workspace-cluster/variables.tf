variable "dbx_account_password" {
  type        = string
  description = "Account Login Password for the Databricks Account"
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username/Email for the Databricks Account"
}

variable "dbx_account_id" {
  type        = string
  description = "Account ID Number for the Databricks Account"
}

variable "dbx_cloud" {
  type        = string
  description = "Flag that decides which Cloud to use for the instance type in Databricks Cluster"
}

variable "vpc_id" {
  type        = string
  description = "ID for the VPC that Databricks will be attaching to."
}

variable "vpc_subnet_ids" {
  type        = set(string)
  description = "List of subnet IDs that will be utilized by Databricks."
}

variable "security_group_ids" {
  type        = set(string)
  description = "List of security group IDs that will be utilized by Databricks."
}
