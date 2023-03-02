########################
####     Intel      ####
########################

########################
####    Required    ####
########################

variable "aws_cross_account_arn" {
  type = string
  description = "ARN that will be used for databricks cross account IAM role."
  default = ""
}

variable "vpc_id" {
  type = string
  description = "ID for the VPC that Databricks will be attaching to."
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username for the Databricks Account"
}

variable "dbx_account_password" {
  type = string
  description = "Account Login Password for the Databricks Account"
}

variable "dbx_account_id" {
  type = string
  description = "Account Login Username for the Databricks Account"
}

variable "vpc_subnet_ids" {
  type = set(string)
  description = "List of subnet IDs that will be utilized by Databricks."
}

variable "security_group_ids" {
  type = set(string)
  description = "List of security group IDs that will be utilized by Databricks."
}

########################  
####     Other      ####
########################
// See https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
variable "aws_iam_policy_attachment_name" {
  type = string
  description = "Name that will be used when attaching the policy to the arn that is created or provided"
  default = "dbx_module_attatchment_policy"
}

variable "tags" {
  type = map(string)
  description = "A map of key / values to apply to the resources that will be created."
  default = {}
}

variable "region" {
  type = string
  description = "AWS Region that will be used as a part of the deployment"
  default = "us-east-2"
}

variable "prefix" {
  type = string
  description = "Prefix that will be added to all resources that are created"
  default = null
}

variable "dbx_credential_name" {
  type = string
  description = "Name that will be associated with the credential configuration in Databricks."
  default = "dbx_module_credential"
}

variable "dbx_network_name" {
  type = string
  description = "Name that will be associated with the network configuration in Databricks."
  default = "dbx_module_network"
}

variable "dbx_workspace_name" {
  type = string
  description = "Name that will be associated with the workspace that will be created in Databricks."
  default = "dbx_module_workspace"
}

variable "dbx_storage_name" {
  type = string
  description = "Name that will be associated with the storage configuration that will be created in Databricks."
  default = "dbx_module_storage"
}

# create_bucket = true, var.bucket_name
# create_bucket = false, var.bucket_name
variable "create_bucket" {
  type = bool
  description = "Boolean that when true will create a root S3 bucket for Databricks to consume."
  default = false
}

variable "bucket_name" {
  type = string
  description = "Name of the existing S3 bucket that Databricks will consume."
  default = "dbx-root-bucket"
}

variable "s3_bucket_acl" {
  type = string
  description = "ACL that will be attached to the S3 bucket (if created) during the provisioning process."
  default = "private"
}

variable "s3_bucket_force_destroy" {
  type = bool
  description = "Flag that determines if a bucket will destroy all contents when a Terraform destroy takes place."
  default = true
}

variable "s3_bucket_versioning" {
  type = string
  description = "Flag that enables/disables versioning of the S3 root storage bucket "
  default = "Disabled"
}

variable "create_aws_account_role" {
  type = bool
  description = "Flag that determines if a cross account role will be created in the AWS account provided."
  default = false
}

variable "aws_cross_account_role_name" {
  type = string
  description = "Flag that determines if a cross account role will be created in the AWS account provided."
  default = "dbx_module_account_role"
}

variable "aws_iam_policy_name" {
  type = string
  description = "Name of the IAM policy that will be created and associated with the aws_account_role_name."
  default = "dbx_module_account_role"
}
