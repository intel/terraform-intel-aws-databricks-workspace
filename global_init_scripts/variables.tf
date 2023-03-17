# Getting the best possible performance out of an application always presents challenges. This fact is especially true when developing machine learning (ML) and artificial intelligence (AI) applications. Over the years, Intel has worked closely with the ecosystem to optimize a broad range of frameworks and libraries for better performance.
# This brief discusses the performance benefits derived from incorporating Intel-optimized ML libraries into Databricks Runtime for Machine Learning on 3rd Generation Intel® Xeon® Platinum processors. The paper focuses on two of the most popular frameworks used in ML and deep learning (DL): scikit-learn and TensorFlow. */
# https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273
variable "dbfs_source" {
  description = "Path of the Intel ML Optimized init_scripts"
  type        = string
  default     = "../../scripts/init_intel_optimized_ml_ex.sh"
}