// Capture the Databricks workspace's URL.
output "databricks_host" {
  value = databricks_mws_workspaces.ws.workspace_url
  description = "value"
}

// Export the Databricks personal access token's value, for integration tests to run on.
# output "databricks_token" {
#   value     = databricks_token.pat.token_value
#   description = "value"
#   sensitive = true
# }

output "databricks_assume_role_policy" {
  value = data.databricks_aws_assume_role_policy.rp.json
  description = "Assume role policy for the Databricks deployment."
}

