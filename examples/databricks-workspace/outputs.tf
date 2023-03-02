# // Capture the Databricks workspace's URL.
# output "databricks_host" {
#   value = module.aws-databricks.databricks_host
# }

# // Export the Databricks personal access token's value, for integration tests to run on.
# output "databricks_token" {
#   value     = module.aws-databricks.databricks_token
#   sensitive = true
# }
