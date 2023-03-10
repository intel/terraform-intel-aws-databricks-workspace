<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks
The module can deploy an Intel Optimized AWS Databricks Workspace and Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)


## Usage

See examples folder for code ./examples/databricks-workspace/main.tf

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
Example of main.tf

```hcl
# Example of how to pass variable for databricks account password:
# terraform apply -var="dbx_account_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Cloud Optimization Module
module "module-example" {
  source = "intel/module-name/intel"
}

```


Required Variables 
```hcl
var.dbx_account_username
var.dbx_account_password
var.dbx_account_id
var.vpc_id
var.vpc_subnet_ids
var.security_group_ids
```


Run Terraform

```hcl
terraform init  
terraform plan
terraform apply
```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources anymore.


## Considerations 

More Information regarding deploying Databricks Workspace [Databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication)

**NOTE**: You cannot create multiple databricks workspaces with the same storage, credentials or network configurations.

**NOTE**: The URL of the created databricks workspaces will be outputed on the finish of terraform apply run. Look for **dbx_host** in outputs for the URL