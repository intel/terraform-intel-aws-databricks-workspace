<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace and Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.

## Usage

**Usage Considerations**
<p>
Databricks Workspace Setup requires three configurations components:

* **Crendentials Configuration**:
  * Default for **var.create_aws_account_role = false**. This means the user must to provide input for:
    * var.aws_cross_account_role_name
    * var.aws_cross_account_arn (Follow this steps to create cross account IAM role in [AWS](https://docs.databricks.com/administration-guide/account-api/iam-role.html))
  * If **var.create_aws_account_role = true**. This means the module will create Credentials Configurations.
* **Storage Configuration**:
  * Default for **var.create_bucket = false**. This means the user must to provide input for:
    * var.bucket_name (Follow this steps to create storage bucket in [AWS](https://docs.databricks.com/administration-guide/account-settings-e2/storage.html))
  * If **var.create_bucket = true**. This means the module will create Storage Configurations.
* **Network Configuration**:
  * By default the user must provide these three variables to create Network config:
    * var.vpc_id
    * var.subnet_ids
    * var.security_group_ids
  * More information on creating VPC and subnets in [Databricks on AWS](https://docs.databricks.com/administration-guide/account-settings-e2/networks.html)

</p>

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

variable "vpc_id" {
  type = string
  description = "ID for the VPC that Databricks will be attaching to."
}

variable "vpc_subnet_ids" {
  type = set(string)
  description = "List of subnet IDs that will be utilized by Databricks."
}

variable "security_group_ids" {
  type = set(string)
  description = "List of security group IDs that will be utilized by Databricks."
}
```
main.tf
```hcl
module "databricks_setup" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
  create_bucket = true
  create_aws_account_role = true
}


module "databricks_workspace" {
  source = "../../created_worksapce"
  depends_on = [
    module.databricks_setup
  ]
  providers = {
    databricks = databricks.workspace
  }
}


```



Run Terraform

```hcl
export TF_VAR_dbx_account_password ='<USE_A_STRONG_PASSWORD>'

terraform init  
terraform plan
terraform apply 
```
## Considerations
More Information regarding deploying Databricks Workspace [Databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication)