terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.9.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
}

}