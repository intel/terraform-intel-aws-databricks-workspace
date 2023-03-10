########################
####     Intel      ####
########################
# # See policies.md, we recommend  Intel Xeon 3rd Generation Scalable processors (code-named Ice Lake)
# Storage Optimized: i4i.large, i4i.xlarge, i4i.2xlarge, i4i.4xlarge, i4i.8xlarge, i4i.16xlarge, i4i.32xlarge
#See more:
#https://www.databricks.com/product/pricing
#https://aws.amazon.com/ec2/instance-types/?trk=36c6da98-7b20-48fa-8225-4784bced9843&sc_channel=ps&s_kwcid=AL!4422!3!536392622533!e!!g!!aws%20ec2%20instance%20pricing&ef_id=CjwKCAiAxvGfBhB-EiwAMPakquCwWM2kyUJf9VQXCzpbGLq5sTsVTgHMMjSvmOb7XyaND-3R_M0iARoC89wQAvD_BwE:G:s&s_kwcid=AL!4422!3!536392622533!e!!g!!aws%20ec2%20instance%20pricing

variable "dbx_node_type_id" {
  description = "The type of the AWS Compute Machine that are supported by databricks."
  type = string
  default = "i4i.2xlarge"
}

#Intel Optimized Tunable Spark Config parameters
variable "dbx_spark_config" {
  description = "Key - Value pair for Intel Optimizations for Spark configuration"
  type = map(string)
  default = {
    "spark.databricks.passthrough.enabled" = "true",
    "spark.databricks.adaptive.autoOptimizeShuffle.enabled" = "true",
    "spark.databricks.io.cache.enabled" = "true",
    "spark.databricks.io.cache.maxMetaDataCache" = "10g",
    "spark.databricks.io.cache.maxDiskUsage" = "100g",
    "spark.databricks.delta.preview.enabled" = "true"
  }
}

# Getting the best possible performance out of an application always presents challenges. This fact is especially true when developing machine learning (ML) and artificial intelligence (AI) applications. Over the years, Intel has worked closely with the ecosystem to optimize a broad range of frameworks and libraries for better performance.
# This brief discusses the performance benefits derived from incorporating Intel-optimized ML libraries into Databricks Runtime for Machine Learning on 2nd Generation Intel® Xeon® Platinum processors. The paper focuses on two of the most popular frameworks used in ML and deep learning (DL): scikit-learn and TensorFlow. */
variable "dbfs_source" {
  description = "Path of the Intel ML Optimized init_scripts"
  type = string
  default = "../../scripts/init_intel_optimized_ml.sh"
}


variable "dbx_runtime_engine" {
  description = " The type of runtime engine to use. If not specified, the runtime engine type is inferred based on the spark_version value. Allowed values include: PHOTON, STANDARD."
  validation {
    condition = contains(["PHOTON" , "STANDARD"], var.dbx_runtime_engine)
    error_message = "The dbx_runtime_engine must be \"PHOTON\" or \"STANDARD\"."
  }
  type = string
  default = "PHOTON"
}
########################
####    Required    ####
########################

########################  
####     Other      ####
########################
variable "dbx_cluster_name" {
  description = "Cluster name, which doesn’t have to be unique. If not specified at creation, the cluster name will be an empty string."
  type = string
  default = "dbx_optimized_cluster"
}

variable "dbx_num_workers" {
  description = " Number of worker nodes that this cluster should have. A cluster has one Spark driver and num_workers executors for a total of num_workers + 1 Spark nodes."
  type = number
  default = 8
}

variable "dbx_auto_terminate_min" {
  description = "Automatically terminate the cluster after being inactive for this time in minutes. If specified, the threshold must be between 10 and 10000 minutes. You can also set this value to 0 to explicitly disable automatic termination. Defaults to 60. We highly recommend having this setting present for Interactive/BI clusters."
  validation {
    condition = var.dbx_auto_terminate_min >= 10 && var.dbx_auto_terminate_min <= 10000
    error_message = "dbx_auto_terminate_min has to between 10 and 10000 minutes"
  }
  type = number
  default = 120
}

variable "tags" {
  description = "Tags"
  type = map(string)
  default = {
    "key" = "value"
  }
}



