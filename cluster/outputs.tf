output "dbx_pat" {
  description = "Personal Access Token"
  value       = databricks_token.pat.token_value
  sensitive   = false
}

output "dbx_cluster_name" {
  description = "Name of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.cluster_name
}

output "dbx_cluster_spark_version" {
  description = "Spark version of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.spark_version
}

output "dbx_cluster_node_type_id" {
  description = "Instance type of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.node_type_id
}

output "dbx_cluster_autoterminate_min" {
  description = "Autoterminate minute of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.autotermination_minutes
}

output "dbx_cluster_runtime_engine" {
  description = "Runtime Engine of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.runtime_engine
}

output "dbx_cluster_num_workers" {
  description = "Num of workers nodes of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.num_workers
}

output "dbx_cluster_spark_conf" {
  description = "Spark Configurations of the databricks cluster"
  value       = databricks_cluster.dbx_cluster.spark_conf
}

output "dbx_cluster_custom_tags" {
  description = "Custom Tags"
  value       = databricks_cluster.dbx_cluster.custom_tags
}