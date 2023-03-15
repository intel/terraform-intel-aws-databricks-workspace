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

* **Step 3 (Optional): Create Storage Config:** The module creates a storage configuration according to the [Databricks Storage Configuration](https://docs.databricks.com/administration-guide/account-settings-e2/storage.html#define-a-storage-configuration-and-generate-a-bucket-policy). If you like to use a pre-existing Databricks AWS S3 storage bucket manually according to the Databricks requirement, then complete Step 3.

  1. Override the **create_bucket** to **false** (By default its true)
  2. [Create an AWS S3 Bucket](https://docs.databricks.com/administration-guide/cloud-configurations/aws/aws-storage.html)
  3. Provide the name of the created S3 bucket to ```bucket_name = <Name of S3 bucket> ```.<br/><br/>

  Checkout the **example/databricks-workspace-non-default-config/main.tf** to see an working example.<br/><br/>
* **Step 4 (Optional): Create Credential Config:** The module creates a credential configuration according to the [Databricks Credential Configuration](https://docs.databricks.com/administration-guide/account-settings-e2/credentials.html#manage-delegated-credential-configurations-using-the-account-console). If you like to use a pre-existing Databricks AWS IAM Role Configuration manually according to the Databricks requirement , then complete Step 4.

  1. Override the **create_aws_account_role** to **false** (By default its true)
  2. [Create an AWS IAM Role](https://docs.databricks.com/administration-guide/cloud-configurations/aws/iam-role.html#create-a-cross-account-role)
  3. Provide the name of the created IAM role name to ```aws_cross_account_role_name = <Name of IAM Role> ```.
  4. Provide the ARN of the created IAM role name to ```aws_cross_account_arn = <ARN of IAM Role> ```.<br/><br/>

  Checkout the **example/databricks-workspace-non-default-config/main.tf** to see an working example.<br/><br/>

**NOTE: At this point you could run the TF init, plan, apply, but this will ONLY create databricks workspace. See examples/databricks-workspace. If you would like to add Intel Optimized Databricks Cluster finish Step 5.**<br/><br/>
* **Step 5: Add the Databricks Cluster Module**: Just have to add this in your main.tf file
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

**Example of main.tf with Default Setting (Step 3 and 4 skipped)**

```hcl
# Example of how to pass variable for databricks account password:
# terraform apply -var="dbx_account_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Cloud Optimization Module
module "module-example" {
  source = "intel/aws-databricks/intel"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
}

module "databricks_cluster" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.module-example
  ]
}

```
Required Variables **(Default setting) (Step 3 and 4 Skipped)**
```hcl
var.dbx_account_username
var.dbx_account_password
var.dbx_account_id
var.vpc_id
var.vpc_subnet_ids
var.security_group_ids
```
**Example of main.tf with Non-Default Setting (Step 3 and 4 inlcuded)**

```hcl
# Example of how to pass variable for databricks account password:
# terraform apply -var="dbx_account_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Cloud Optimization Module
module "module-example" {
  source = "intel/aws-databricks/intel"
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
  create_bucket = false
  bucket_name = "dbx-root-storage-bucket"
  create_aws_account_role = false
  aws_cross_account_role_name = "shreejan-dbx"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/shreejan-dbx"
}

module "databricks_cluster" {
  source = "../../cluster"
  providers = {
    databricks = databricks.workspace
  }
  depends_on = [
    module.module-example
  ]
  
}

```

Required Variables **(Non -default setting) (Step 3 and 4 Included)**
```hcl
var.dbx_account_username
var.dbx_account_password
var.dbx_account_id
var.vpc_id
var.vpc_subnet_ids
var.security_group_ids
var.bucket_name                    #If create_bucket is set to false
var.aws_cross_account_role_name    #If create_aws_account_role is set to false
var.aws_cross_account_arn          #If create_aws_account_role is set to false

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