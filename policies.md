<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform  

© Copyright 2022, Intel Corporation

## HashiCorp Sentinel Policies

This file documents the HashiCorp Sentinel policies that apply to this module

## Policy 1

Description: Intel Xeon 3rd Generation Scalable processors (code-named Ice Lake) should be used

Resource type: databricks_cluster

Parameter: node_type_id

Allowed Types

- **Storage Optimized:** i4i.large, i4i.xlarge, i4i.2xlarge, i4i.4xlarge, i4i.8xlarge, i4i.16xlarge, i4i.32xlarge

## Policy 2  

Description: Provisioned PHOTON runtime engine should be used for enhanced performance

Resource type: databricks_cluster

Parameter: runtime_engine

Allowed Type: PHOTON

## Policy 3  

Description: databricks_cluster

Resource type: databricks_cluster

Parameter: spark_conf

Allowed Type: map(string) #(Cannot be null)

## Links

<https://aws.amazon.com/ec2/instance-types/i4i/>

<https://www.databricks.com/blog/2022/09/13/faster-insights-databricks-photon-using-aws-i4i-instances-latest-intel-ice-lake>

<https://www.databricks.com/product/pricing>