<p align="center">
  <img src="https://github.com/OTCShare2/terraform-intel-hashicorp/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace and Clusters. Instance Selection and Intel Optimizations have been defaulted in the code.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)

## Usage

See examples folder for code ./examples/databricks-workspace/main.tf

All the examples in example folder shows how to create a databricks workspace using this module. Additionally, some of the examples display how to create a databricks cluster with the workspace using this module.

**Usage Considerations**

<p>

* **Step 1 : Prerequisites:**

  1.  [Create a databricks account.](https://www.databricks.com/try-databricks?itm_data=Homepage-HeroCTA-Trial#account). Remember the **email** and **password** used to create an Databricks account.
  2.  After logging in the account, in the top right corner you can find your **Databricks Account ID**<br/><br/>
* **Step 2: Create Network Config:** User need to satisfy the Databircks Network Requirements

  1.  Follow the steps here to [create VPC with subnets and security groups](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html#create-a-vpc) in your AWS Console.<br/><br/>

  If you already have pre-existing VPC with subnet and security group that satisfy [Databricks VPC Requirement](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html#vpc-requirements-1), you can also use that network config. 
 
  See examples/databricks-workspace-network-config to see how you can create your VPC with subnets and security group using terraform and then use that VPC for the creation of the databricks workspace.<br/><br/>

**NOTE: At this point you could run the TF init, plan, apply, but this will ONLY create databricks workspace. See examples/databricks-workspace. If you would like to add Intel Optimized Databricks Cluster finish Step 5.**<br/><br/>

* **Step 3: Add the Databricks Cluster Module**: Just have to add this in your main.tf file
```hcl
module "databricks_cluster" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.<NAME_OF_MODULE_THAT_CREATES_DBX_WORKSPACE>
  ]
}
```
Checkout the **example/databricks-workspace-cluster/main.tf** to see an working example.<br/><br/>
# 
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
#This example creates an databricks workspace with the default Credentials, Storage and Network Configurations and Multiple Databricks Cluster with Intel Optimizations. For more information on usage configuration, use the README.md
module "databricks_workspace" {
  source = "../../"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
}

module "databricks_cluster_1" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.databricks_workspace
  ]
}

module "databricks_cluster_2" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.databricks_workspace
  ]
  dbx_cluster_name = "dbx_optimized_cluster_2"
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

Make sure that module name that setups the databricks workspace in main.tf matches the "host = module.<Module_Name>.dbx_host" in the databricks.workspace provider in provider.tf

**NOTE**: You cannot create multiple databricks workspaces with the same storage, credentials or network configurations.

**NOTE**: The URL of the created databricks workspaces will be outputed on the finish of terraform apply run. Look for **dbx_host** in outputs for the URL