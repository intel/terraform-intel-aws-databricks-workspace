// Capture the Databricks workspace's URL.
output "dbx_host" {
  description = "URL of the Databricks workspace"
  value = module.databricks_setup.dbx_host

}

output "dbx_id" {
  description = "ID of the Databricks workspace"
  value = module.databricks_setup.dbx_id
}

output "dbx_account_id" {
  description = "Account ID for the Databricks Account"
  value = module.databricks_setup.dbx_account_id
  sensitive = true
}

### Credentials #####
output "dbx_role_arn" {
  description = "ARN that will be used for databricks cross account IAM role."
  value = module.databricks_setup.dbx_role_arn
}

output "dbx_credentials_name" {
  description = "Name that will be associated with the credential configuration in Databricks."
  value = module.databricks_setup.dbx_credentials_name
}

### Network #####
output "dbx_network_name" {
  description = "Name that will be associated with the network configuration in Databricks."
  value = module.databricks_setup.dbx_network_name
}

output "dbx_vpc_id" {
  description = "ID for the VPC that Databricks will be attaching to."
  value = module.databricks_setup.dbx_vpc_id
}

output "dbx_vpc_subnet_ids" {
  description = "List of subnet IDs that will be utilized by Databricks."
  value = module.databricks_setup.dbx_vpc_subnet_ids
}

output "dbx_security_group_ids" {
  description = "List of security group IDs that will be utilized by Databricks."
  value = module.databricks_setup.dbx_security_group_ids
}

### Storage #####

output "dbx_bucket_name" {
  description = "Name of the existing S3 bucket that Databricks will consume."
  value = module.databricks_setup.dbx_bucket_name
}

output "dbx_storage_configuration_name" {
  description = "Name of the existing S3 bucket that Databricks will consume."
  value = module.databricks_setup.dbx_storage_configuration_name
}


