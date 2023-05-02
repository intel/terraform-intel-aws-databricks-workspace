<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-databricks/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS Databricks

The module can deploy an Intel Optimized AWS Databricks Workspace.

**Learn more about optimizations :**

[Databricks Photon using AWS i4i](https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake)

[Accelerating Databricks Runtime for Machine Learning](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/accelerating-azure-databricks-runtime-for-machine-learning/ba-p/3524273)

## Usage

This example showcases how to uses the [Intel Databricks Cluster](https://registry.terraform.io/modules/intel/databricks-cluster/intel/latest) with the given Intel AWS Databricks Workspace Module.

**Usage Considerations**

<p>

* **Prerequisites:**

  1.  [Create a databricks account.](https://www.databricks.com/try-databricks?itm_data=Homepage-HeroCTA-Trial#account). Remember the **email** and **password** used to create an Databricks account.

  2.  After logging in the account, in the top right corner you can find your **Databricks Account ID**

  3.  Follow the steps here to [create VPC with subnets and security groups](https://docs.databricks.com/administration-guide/cloud-configurations/aws/customer-managed-vpc.html#create-a-vpc) in your AWS Console.

  4.  Configure the **providers.tf** like shown in this example. It is important to configure both providers as Databricks Workspace and Cluster use seperate providers to deploy resources.

  5.  Create a terraform.tfvars file and fill in the details. 

      ```hcl
      dbx_account_id       = <"ENTER YOUR DATABRICKS ACCT ID NUMBER"> 
      dbx_account_password = <"ENTER YOUR DATABRICKS ACCT PASSWORD">
      dbx_account_username = <"ENTER YOUR DATABRICKS ACCT USERNAME">
      vpc_id               = <"vpc-XXXXXX-XXX">
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