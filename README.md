<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-databricks/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2024, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace.

**Learn more about optimizations :**
## Performance Data

<center>

#### [Faster insights With Databricks Photon Using AWS i4i Instances With the Latest Intel Ice Lake Scalable Processors](https://www.databricks.com/blog/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake-scalable)

<p align="center">
  <a href="https://www.databricks.com/blog/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake-scalable">
  <img src="https://github.com/intel/terraform-intel-aws-databricks-workspace/blob/main/images/aws-dbx-1.png?raw=true" alt="Link" width="600"/>
  </a>
</p>

#
#### [5.3x relative speed up of i4i Photon against the i3 DBR](https://www.databricks.com/blog/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake-scalable)

<p align="center">
  <a href="https://www.databricks.com/blog/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake-scalable">
  <img src="https://github.com/intel/terraform-intel-aws-databricks-workspace/blob/main/images/aws-dbx-2.png?raw=true" alt="Link" width="600"/>
  </a>
</p>

#
#### [Accelerating Azure Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)

<p align="center">
  <a href="https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273">
  <img src="https://github.com/intel/terraform-intel-aws-databricks-workspace/blob/main/images/dbx-runtime.png?raw=true" alt="Link" width="600"/>
  </a>
</p>

#

</center>

## Usage

See examples folder for code ./examples/databricks-workspace/main.tf

All the examples in example folder shows how to create a databricks workspace using this module. Additionally, some of the examples display how to create a databricks cluster with the workspace using this module.

**Usage Considerations**

<p>

* **Prerequisites:**

  1.  [Create a databricks account.](https://www.databricks.com/try-databricks?itm_data=Homepage-HeroCTA-Trial#account). Remember the **email** and **password** used to create an Databricks account.

  2.  After logging in the account, in the top right corner you can find your **Databricks Account ID**

  3. Follow the steps here to [create VPC with subnets and security groups](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html#create-a-vpc) in your AWS Console.

  4.  Create a terraform.tfvars file and fill in the details. 
```hcl
dbx_account_id       = <""> 
dbx_account_password = <"">
dbx_account_username = <"">
vpc_id               = <"">
vpc_subnet_ids       = <["subnet-XXXX", "subnet-XXXXX"]>
security_group_ids   = <["sg-XXXX"]>
```
Run Terraform

```hcl
terraform init  
terraform plan
terraform apply 
```
## Considerations
More Information regarding deploying Databricks Workspace [Databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.31 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 1.14.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.31 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | ~> 1.14.2 |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | ~> 1.14.2 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.iap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.ipa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.ir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.rsb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.root_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.sbv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [databricks_global_init_script.intel_optimized_script](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/global_init_script) | resource |
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
| <a name="input_enable_intel_tags"></a> [enable\_intel\_tags](#input\_enable\_intel\_tags) | If true adds additional Intel tags to resources | `bool` | `true` | no |
| <a name="input_intel_tags"></a> [intel\_tags](#input\_intel\_tags) | Intel Tags | `map(string)` | <pre>{<br>  "intel-module": "terraform-intel-aws-databricks-workspace",<br>  "intel-registry": "https://registry.terraform.io/namespaces/intel"<br>}</pre> | no |
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
| <a name="output_dbx__s3_storage_configuration_name"></a> [dbx\_\_s3\_storage\_configuration\_name](#output\_dbx\_\_s3\_storage\_configuration\_name) | Name of the existing S3 bucket that Databricks will consume. |
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
| <a name="output_dbx_vpc_id"></a> [dbx\_vpc\_id](#output\_dbx\_vpc\_id) | ID for the VPC that Databricks will be attaching to. |
| <a name="output_dbx_vpc_subnet_ids"></a> [dbx\_vpc\_subnet\_ids](#output\_dbx\_vpc\_subnet\_ids) | List of subnet IDs that will be utilized by Databricks. |
<!-- END_TF_DOCS -->