// Capture the Databricks workspace's URL.
output "dbx_host" {
  description = "URL of the Databricks workspace"
  value       = module.databricks_workspace.dbx_host

}

output "dbx_id" {
  description = "ID of the Databricks workspace"
  value       = module.databricks_workspace.dbx_id
}

output "dbx_account_id" {
  description = "Account ID for the Databricks Account"
  value       = module.databricks_workspace.dbx_account_id
  sensitive   = true
}

### Credentials #####
output "dbx_role_arn" {
  description = "ARN that will be used for databricks cross account IAM role."
  value       = module.databricks_workspace.dbx_role_arn
}

output "dbx_credentials_name" {
  description = "Name that will be associated with the credential configuration in Databricks."
  value       = module.databricks_workspace.dbx_credentials_name
}

output "dbx_create_role" {
  description = "Flag to create AWS IAM Role or not"
  value       = module.databricks_workspace.dbx_create_role
}

### Network #####
output "dbx_network_name" {
  description = "Name that will be associated with the network configuration in Databricks."
  value       = module.databricks_workspace.dbx_network_name
}

output "dbx_vpc_id" {
  description = "ID for the VPC that Databricks will be attaching to."
  value       = module.databricks_workspace.dbx_vpc_id
}

output "dbx_vpc_subnet_ids" {
  description = "List of subnet IDs that will be utilized by Databricks."
  value       = module.databricks_workspace.dbx_vpc_subnet_ids
}

output "dbx_security_group_ids" {
  description = "List of security group IDs that will be utilized by Databricks."
  value       = module.databricks_workspace.dbx_security_group_ids
}

### Storage #####

output "dbx_bucket_name" {
  description = "Name of the existing S3 bucket that Databricks will consume."
  value       = module.databricks_workspace.dbx_bucket_name
}

output "dbx_storage_configuration_name" {
  description = "Name of the existing S3 bucket that Databricks will consume."
  value       = module.databricks_workspace.dbx_storage_configuration_name
}

output "dbx_create_bucket" {
  description = "Flag to create AWS S3 bucket or not"
  value       = module.databricks_workspace.dbx_create_bucket
}