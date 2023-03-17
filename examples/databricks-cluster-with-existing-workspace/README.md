<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-databricks/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.
This module requires you to have Databricks workspace setup. As it will prompt for the URL of the DBX workspace.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)

## Usage

```
NOTE : This example assumes you have a pre-existing databricks workspace. User will need to provide the URL of their databricks workspace in order to add Intel Optimized Databricks Cluster to their pre-existing workspace
```

**See examples folder for complete examples.**

variables.tf
```hcl
variable "dbx_account_password" {
  type = string
  description = "Account Login Password for the Databricks Account"
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username/Email for the Databricks Account"
}

variable "dbx_account_id" {
  type = string
  description = "Account ID Number for the Databricks Account"
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
  source = "../../cluster"
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

**NOTE**: You cannot create multiple databricks workspaces with the same storage, credentials or network configurations.

**NOTE**: The URL of the created databricks workspaces will be outputed on the finish of terraform apply run. Look for **dbx_host** in outputs for the URL