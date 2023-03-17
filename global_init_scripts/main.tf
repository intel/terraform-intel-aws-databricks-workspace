resource "databricks_global_init_script" "intel_optimized_script" {
  source  = var.dbfs_source
  name    = "Intel Optimized Init Script"
  enabled = true
}