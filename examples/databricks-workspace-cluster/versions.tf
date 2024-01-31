terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.14.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}
