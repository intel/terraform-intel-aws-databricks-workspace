<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-databricks/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
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
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.15.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 1.9.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.15.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | ~> 1.9.2 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gis"></a> [gis](#module\_gis) | ./global_init_scripts | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.iap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.ipa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.ir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.rsb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.ba](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.root_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.sbv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [databricks_mws_credentials.cr](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_credentials) | resource |
| [databricks_mws_networks.nw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_networks) | resource |
| [databricks_mws_storage_configurations.sc](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_storage_configurations) | resource |
| [databricks_mws_workspaces.ws](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_workspaces) | resource |
| [random_string.naming](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [databricks_aws_assume_role_policy.rp](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/aws_assume_role_policy) | data source |
| [databricks_aws_bucket_policy.bp](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/aws_bucket_policy) | data source |
| [databricks_aws_crossaccount_policy.cap](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/aws_crossaccount_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_cross_account_arn"></a> [aws\_cross\_account\_arn](#input\_aws\_cross\_account\_arn) | ARN that will be used for databricks cross account IAM role. | `string` | `""` | no |
| <a name="input_aws_cross_account_role_name"></a> [aws\_cross\_account\_role\_name](#input\_aws\_cross\_account\_role\_name) | Flag that determines if a cross account role will be created in the AWS account provided. | `string` | `"dbx_module_account_role"` | no |
| <a name="input_aws_iam_policy_attachment_name"></a> [aws\_iam\_policy\_attachment\_name](#input\_aws\_iam\_policy\_attachment\_name) | Name that will be used when attaching the policy to the arn that is created or provided | `string` | `"dbx_module_attatchment_policy"` | no |
| <a name="input_aws_iam_policy_name"></a> [aws\_iam\_policy\_name](#input\_aws\_iam\_policy\_name) | Name of the IAM policy that will be created and associated with the aws\_account\_role\_name. | `string` | `"dbx_module_account_role"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the existing S3 bucket that Databricks will consume. | `string` | `"dbx-root-bucket"` | no |
| <a name="input_create_aws_account_role"></a> [create\_aws\_account\_role](#input\_create\_aws\_account\_role) | Flag that determines if a cross account role will be created in the AWS account provided. | `bool` | `true` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Boolean that when true will create a root S3 bucket for Databricks to consume. | `bool` | `true` | no |
| <a name="input_dbx_account_id"></a> [dbx\_account\_id](#input\_dbx\_account\_id) | Account ID Number for the Databricks Account | `string` | n/a | yes |
| <a name="input_dbx_account_password"></a> [dbx\_account\_password](#input\_dbx\_account\_password) | Account Login Password for the Databricks Account | `string` | n/a | yes |
| <a name="input_dbx_account_username"></a> [dbx\_account\_username](#input\_dbx\_account\_username) | Account Login Username/Email for the Databricks Account | `string` | n/a | yes |
| <a name="input_dbx_credential_name"></a> [dbx\_credential\_name](#input\_dbx\_credential\_name) | Name that will be associated with the credential configuration in Databricks. | `string` | `"dbx_module_credential"` | no |
| <a name="input_dbx_network_name"></a> [dbx\_network\_name](#input\_dbx\_network\_name) | Name that will be associated with the network configuration in Databricks. | `string` | `"dbx_module_network"` | no |
| <a name="input_dbx_storage_name"></a> [dbx\_storage\_name](#input\_dbx\_storage\_name) | Name that will be associated with the storage configuration that will be created in Databricks. | `string` | `"dbx_module_storage"` | no |
| <a name="input_dbx_workspace_name"></a> [dbx\_workspace\_name](#input\_dbx\_workspace\_name) | Name that will be associated with the workspace that will be created in Databricks. | `string` | `"dbx_module_workspace"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix that will be added to all resources that are created | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region that will be used as a part of the deployment | `string` | `"us-east-2"` | no |
| <a name="input_s3_bucket_acl"></a> [s3\_bucket\_acl](#input\_s3\_bucket\_acl) | ACL that will be attached to the S3 bucket (if created) during the provisioning process. | `string` | `"private"` | no |
| <a name="input_s3_bucket_force_destroy"></a> [s3\_bucket\_force\_destroy](#input\_s3\_bucket\_force\_destroy) | Flag that determines if a bucket will destroy all contents when a Terraform destroy takes place. | `bool` | `true` | no |
| <a name="input_s3_bucket_versioning"></a> [s3\_bucket\_versioning](#input\_s3\_bucket\_versioning) | Flag that enables/disables versioning of the S3 root storage bucket | `string` | `"Disabled"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs that will be utilized by Databricks. | `set(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of key / values to apply to the resources that will be created. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID for the VPC that Databricks will be attaching to. | `string` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of subnet IDs that will be utilized by Databricks. | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbx_account_id"></a> [dbx\_account\_id](#output\_dbx\_account\_id) | Account ID for the Databricks Account |
| <a name="output_dbx_bucket_name"></a> [dbx\_bucket\_name](#output\_dbx\_bucket\_name) | Name of the existing S3 bucket that Databricks will consume. |
| <a name="output_dbx_create_bucket"></a> [dbx\_create\_bucket](#output\_dbx\_create\_bucket) | Flag to create AWS S3 bucket or not. |
| <a name="output_dbx_create_role"></a> [dbx\_create\_role](#output\_dbx\_create\_role) | Flag to create AWS IAM Role or not. |
| <a name="output_dbx_credentials_name"></a> [dbx\_credentials\_name](#output\_dbx\_credentials\_name) | Name that will be associated with the credential configuration in Databricks. |
| <a name="output_dbx_host"></a> [dbx\_host](#output\_dbx\_host) | URL of the Databricks workspace |
| <a name="output_dbx_id"></a> [dbx\_id](#output\_dbx\_id) | ID of the Databricks workspace |
| <a name="output_dbx_network_name"></a> [dbx\_network\_name](#output\_dbx\_network\_name) | Name that will be associated with the network configuration in Databricks. |
| <a name="output_dbx_role_arn"></a> [dbx\_role\_arn](#output\_dbx\_role\_arn) | ARN that will be used for databricks cross account IAM role. |
| <a name="output_dbx_security_group_ids"></a> [dbx\_security\_group\_ids](#output\_dbx\_security\_group\_ids) | List of security group IDs that will be utilized by Databricks. |
| <a name="output_dbx_storage_configuration_name"></a> [dbx\_storage\_configuration\_name](#output\_dbx\_storage\_configuration\_name) | Name of the existing S3 bucket that Databricks will consume. |
| <a name="output_dbx_vpc_id"></a> [dbx\_vpc\_id](#output\_dbx\_vpc\_id) | ID for the VPC that Databricks will be attaching to. |
| <a name="output_dbx_vpc_subnet_ids"></a> [dbx\_vpc\_subnet\_ids](#output\_dbx\_vpc\_subnet\_ids) | List of subnet IDs that will be utilized by Databricks. |
<!-- END_TF_DOCS -->