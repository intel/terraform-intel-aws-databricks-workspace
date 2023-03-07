###################### VPC #########################
// Create the required VPC resources in your AWS account.
// See https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

   name = local.prefix
   cidr = var.cidr_block
   azs  = data.aws_availability_zones.available.names
   tags = var.tags

   enable_dns_hostnames = true
   enable_nat_gateway   = true
   single_nat_gateway   = true
   create_igw           = true

   public_subnets = [cidrsubnet(var.cidr_block, 3, 0)]
   private_subnets = [cidrsubnet(var.cidr_block, 3, 1),
   cidrsubnet(var.cidr_block, 3, 2)]

   manage_default_security_group = true
   default_security_group_name   = "${local.prefix}-sg"

   default_security_group_egress = [{
     cidr_blocks = "0.0.0.0/0"
   }]

   default_security_group_ingress = [{
     description = "Allow all internal TCP and UDP"
     self        = true
   }]
 }

# // Create the required VPC endpoints within your AWS account.
# // See https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest/submodules/vpc-endpoints
module "vpc_endpoints" {
   source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
   version = "3.2.0"

   vpc_id             = module.vpc.vpc_id
   security_group_ids = [module.vpc.default_security_group_id]

   endpoints = {
     s3 = {
       service      = "s3"
       service_type = "Gateway"
       route_table_ids = flatten([
         module.vpc.private_route_table_ids,
       module.vpc.public_route_table_ids])
       tags = {
         Name = "${local.prefix}-s3-vpc-endpoint"
       }
     },
     sts = {
       service             = "sts"
       private_dns_enabled = true
       subnet_ids          = module.vpc.private_subnets
       tags = {
         Name = "${local.prefix}-sts-vpc-endpoint"
       }
     },
     kinesis-streams = {
       service             = "kinesis-streams"
       private_dns_enabled = true
       subnet_ids          = module.vpc.private_subnets
       tags = {
         Name = "${local.prefix}-kinesis-vpc-endpoint"
       }
     }
   }

   tags = var.tags
}

module "databricks_setup" {
  source = "../../"
  dbx_account_id = var.dbx_account_id
  dbx_account_password = var.dbx_account_password
  dbx_account_username = var.dbx_account_username
  bucket_name = "dbx-root-storage-bucket"
  aws_cross_account_role_name = "dbx-cross-account-role"
  aws_cross_account_arn = "arn:aws:iam::499974397304:role/dbx-cross-account-role"

  #Network Config
  vpc_id = module.vpc.id
  
}