### Databricks Cluster #####
output "dbx_host" {
  description = "URL of given workspace"
  value       = var.dbx_host
}
output "dbx_cluster_name" {
  description = "Name of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_name
}

output "dbx_cluster_spark_version" {
  description = "Spark version of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_spark_version
}

output "dbx_cluster_node_type_id" {
  description = "Instance type of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_node_type_id
}

output "dbx_cluster_autoterminate_min" {
  description = "Autoterminate minute of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_autoterminate_min
}

output "dbx_cluster_runtime_engine" {
  description = "Runtime Engine of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_runtime_engine
}

output "dbx_cluster_num_workers" {
  description = "Num of workers nodes of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_num_workers
}

output "dbx_cluster_spark_conf" {
  description = "Spark Configurations of the databricks cluster"
  value       = module.databricks_cluster.dbx_cluster_spark_conf
}

output "dbx_cluster_custom_tags" {
  description = "Custom Tags"
  value       = module.databricks_cluster.dbx_cluster_custom_tags
}
