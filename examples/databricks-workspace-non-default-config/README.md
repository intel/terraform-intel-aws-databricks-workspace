<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-databricks/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2025, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace and Cluster. Instance Selection and Intel Optimizations have been defaulted in the code.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake-scalable)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)

## Usage

See examples folder for code ./examples/databricks-workspace/main.tf

All the examples in example folder shows how to create a databricks workspace using this module. Additionally, some of the examples display how to create a databricks cluster with the workspace using this module.

**Usage Considerations**

<p>

* **Prerequisites:**

  1.  [Create a databricks account.](https://www.databricks.com/try-databricks?itm_data=Homepage-HeroCTA-Trial#account). Remember the **email** and **password** used to create an Databricks account.

  2.  After logging in the account, in the top right corner you can find your **Databricks Account ID**

  3. Follow the steps here to [create VPC with subnets and security groups](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html#create-a-vpc) in your AWS Console.

  4. Checkout the **example/databricks-workspace-non-default-config/main.tf** to see an working example on how to use pre-existing **S3 storage bucket** and **IAM Cross Account Role** in your AWS account. For more information on creating bucket and role see USAGE.md

  5.  Create a terraform.tfvars file and fill in the details. 
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