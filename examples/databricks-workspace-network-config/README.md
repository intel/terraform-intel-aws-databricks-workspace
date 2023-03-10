<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)
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
  description = "Account Login Username/Email for the Databricks Account"
}

variable "dbx_account_id" {
  type = string
  description = "Account ID Number for the Databricks Account"
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
#This example creates an databricks workspace with the default Credentials and Storage Configurations. 
#This example creates VPC and VPC endpoints for the network config to use for the setup of the databricks workspace. 
#For more information on usage configuration, use the README.md
locals {
  prefix = "Test-Network"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"
  ....  
  ....

}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.2.0"
  ....
  ....
  
}

module "databricks_workspace" {
  source = "../../"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  bucket_name = "dbx-root-storage-bucket"
  aws_cross_account_role_name = "dbx-cross-account-role"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/dbx-cross-account-role"
  
  #Network Config
  vpc_id = module.vpc.vpc_id
  vpc_subnet_ids = module.vpc.private_subnets
  security_group_ids = [module.vpc.default_security_group_id]  

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