<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.

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
  bucket_name = "dbx-root-storage-bucket"
  aws_cross_account_role_name = "dbx-cross-account-role"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/dbx-cross-account-role"
}

```



Run Terraform

```hcl
export TF_VAR_dbx_account_password ='<USE_A_DBX_ACCOUNT_PASSWORD>'

terraform init  
terraform plan
terraform apply 
```
## Considerations
More Information regarding deploying Databricks Workspace [Databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication)