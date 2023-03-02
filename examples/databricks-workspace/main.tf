# module "aws-databricks" {
#   source                      = "../.."
#   databricks_account_id       = "f36297ba-ff38-4b4b-b5be-0a14d4b6d095"
#   databricks_account_password = "Blackdown2112!"
#   databricks_account_username = "shreejan.mistry@intel.com"
# }

###################### VPC #########################

// Allow access to the list of AWS Availability Zones within the AWS Region that is configured in vars.tf and init.tf.
// See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "available" {}


# // Create the required VPC resources in your AWS account.
# // See https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "3.2.0"

#   name = local.prefix
#   cidr = var.cidr_block
#   azs  = data.aws_availability_zones.available.names
#   tags = var.tags

#   enable_dns_hostnames = true
#   enable_nat_gateway   = true
#   single_nat_gateway   = true
#   create_igw           = true

#   public_subnets = [cidrsubnet(var.cidr_block, 3, 0)]
#   private_subnets = [cidrsubnet(var.cidr_block, 3, 1),
#   cidrsubnet(var.cidr_block, 3, 2)]

#   manage_default_security_group = true
#   default_security_group_name   = "${local.prefix}-sg"

#   default_security_group_egress = [{
#     cidr_blocks = "0.0.0.0/0"
#   }]

#   default_security_group_ingress = [{
#     description = "Allow all internal TCP and UDP"
#     self        = true
#   }]
# }

# // Create the required VPC endpoints within your AWS account.
# // See https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest/submodules/vpc-endpoints
# module "vpc_endpoints" {
#   source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
#   version = "3.2.0"

#   vpc_id             = module.vpc.vpc_id
#   security_group_ids = [module.vpc.default_security_group_id]

#   endpoints = {
#     s3 = {
#       service      = "s3"
#       service_type = "Gateway"
#       route_table_ids = flatten([
#         module.vpc.private_route_table_ids,
#       module.vpc.public_route_table_ids])
#       tags = {
#         Name = "${local.prefix}-s3-vpc-endpoint"
#       }
#     },
#     sts = {
#       service             = "sts"
#       private_dns_enabled = true
#       subnet_ids          = module.vpc.private_subnets
#       tags = {
#         Name = "${local.prefix}-sts-vpc-endpoint"
#       }
#     },
#     kinesis-streams = {
#       service             = "kinesis-streams"
#       private_dns_enabled = true
#       subnet_ids          = module.vpc.private_subnets
#       tags = {
#         Name = "${local.prefix}-kinesis-vpc-endpoint"
#       }
#     }
#   }

#   tags = var.tags
# }

module "databricks_setup" {
  source = "../../"
  # vpc_id = module.vpc.vpc_id
  vpc_id = "vpc-047043965cbe4967b"
  dbx_account_id = "f36297ba-ff38-4b4b-b5be-0a14d4b6d095"
  dbx_account_password = "Blackdown2112!"
  dbx_account_username = "shreejan.mistry@intel.com"
  # vpc_subnet_ids = module.vpc.private_subnets
  vpc_subnet_ids = ["subnet-0b22c8e6b9f2e956c" , "subnet-0c53fc70a0e3ed9f0"]
  security_group_ids = ["sg-0c26302989e5391b5"]
  create_bucket = true
  bucket_name = "test-root-storage-bucket"
  create_aws_account_role = true
  # aws_cross_account_role_name = "dbx_test_cross_act"
  # aws_cross_account_arn = "arn:aws:iam::499974397304:role/test-cross-acct"
}


module "databricks_workspace" {
  source = "../../created_worksapce"
  depends_on = [
    module.databricks_setup
  ]
  providers = {
    databricks = databricks.workspace
  }
}

