<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.
This module requires you to have Databricks workspace setup. As it will prompt for the URL of the DBX workspace

## Usage


**See examples folder for complete examples.**

variables.tf
```hcl
variable "dbx_account_password" {
  type = string
  description = "Account Login Password for the Databricks Account"
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username for the Databricks Account"
}

variable "dbx_account_id" {
  type = string
  description = "Account Login Username for the Databricks Account"
}

variable "dbx_host" {
  type = string
  description = "Required URL for the databricks workspace"
}


```
main.tf
```hcl
# This example creates databricks cluster on an existing dbx workspace. URL for the dbx workspace must be provided when prompted
module "databricks_workspace" {
  source = "../../created_workspace"
  providers = {
    databricks = databricks.workspace
  }
}

```



Run Terraform

```hcl
terraform init  
terraform plan  -var="dbx_host=https://dbc-42d1aa5f-eadb.cloud.databricks.com/"
terraform apply -var="dbx_host=https://dbc-42d1aa5f-eadb.cloud.databricks.com/"
```
## Considerations
More Information regarding deploying Databricks Workspace [Databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication)