resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

############################## Credentials Config ###################################

data "databricks_aws_assume_role_policy" "rp" {
  external_id = var.dbx_account_id
}

data "databricks_aws_crossaccount_policy" "cap" {}

resource "aws_iam_policy" "iap" {
  name   = var.prefix != null ? "${var.prefix}-${var.aws_iam_policy_name}" : "${var.aws_iam_policy_name}"
  policy = data.databricks_aws_crossaccount_policy.cap.json
}

resource "aws_iam_policy_attachment" "ipa" {
  name       = var.aws_iam_policy_attachment_name
  roles      = [var.prefix != null ? "${var.prefix}-${var.aws_cross_account_role_name}" : "${var.aws_cross_account_role_name}"]
  policy_arn = aws_iam_policy.iap.arn
  lifecycle {
    precondition {
      condition     = (var.create_aws_account_role == false && var.aws_cross_account_role_name != "dbx_module_account_role") || var.create_aws_account_role == true
      error_message = "If you are providing an AWS Cross Account Role please change \"var.aws_cross_account_role_name\" to your Role name."
    }
  }
}

// Create the required IAM role in your AWS account.
// See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ir" {
  count              = var.create_aws_account_role ? 1 : 0
  name               = var.prefix != null ? "${var.prefix}-${random_string.naming.result}-${var.aws_cross_account_role_name}" : "${var.aws_cross_account_role_name}"
  assume_role_policy = data.databricks_aws_assume_role_policy.rp.json
  tags               = var.tags
}

resource "databricks_mws_credentials" "cr" {
  depends_on       = [time_sleep.wait]
  account_id       = var.dbx_account_id
  role_arn         = var.aws_cross_account_arn != "" ? var.aws_cross_account_arn : aws_iam_role.ir[0].arn
  credentials_name = var.prefix != null ? "${var.prefix}-${var.dbx_credential_name}" : var.dbx_credential_name
  lifecycle {
    precondition {
      condition     = (var.create_aws_account_role == false && var.aws_cross_account_arn != "") || var.create_aws_account_role == true
      error_message = "If you are providing an AWS Cross Account Role please change \"var.aws_cross_account_arn\" to your Role ARN."
    }
  }
}

############################## Storage Config ###################################

// Create the S3 root bucket.
// See https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
resource "aws_s3_bucket" "rsb" {
  count         = var.create_bucket ? 1 : 0
  bucket        = var.prefix != null ? "${var.prefix}-${random_string.naming.result}-${var.bucket_name}" : "${random_string.naming.result}-${var.bucket_name}"
  force_destroy = var.s3_bucket_force_destroy
  acl           = var.s3_bucket_acl
  tags = merge(var.tags, {
    Name = var.prefix != null ? "${var.prefix}-${random_string.naming.result}-${var.bucket_name}" : "${random_string.naming.result}-${var.bucket_name}"
  })
}


resource "aws_s3_bucket_versioning" "sbv" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.rsb[0].id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}

// Configure a simple access policy for the S3 root bucket within your AWS account, so that Databricks can access data in it.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/aws_bucket_policy
data "databricks_aws_bucket_policy" "bp" {
  bucket = var.create_bucket ? aws_s3_bucket.rsb[0].bucket : var.bucket_name
  lifecycle {
    precondition {
      condition     = (var.create_bucket == false && var.bucket_name != "dbx-root-bucket") || var.create_bucket == true
      error_message = "If you are providing an S3 bucket please change \"var.bucket_name\" to a non-default value."
    }
  }
}


// Attach the access policy to the S3 root bucket within your AWS account.
// See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = var.create_bucket ? aws_s3_bucket.rsb[0].id : var.bucket_name
  policy = data.databricks_aws_bucket_policy.bp.json
  lifecycle {
    precondition {
      condition     = (var.create_bucket == false && var.bucket_name != "dbx-root-bucket") || var.create_bucket == true
      error_message = "If you are providing an S3 bucket please change \"var.bucket_name\" to a non-default value."
    }
  }
}



// Configure the S3 root bucket within your AWS account for new Databricks workspaces.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_storage_configurations
resource "databricks_mws_storage_configurations" "sc" {
  account_id                 = var.dbx_account_id
  bucket_name                = var.create_bucket ? aws_s3_bucket.rsb[0].bucket : var.bucket_name
  storage_configuration_name = var.prefix != null ? "${var.prefix}-${var.dbx_storage_name}" : var.dbx_storage_name
  lifecycle {
    precondition {
      condition     = (var.create_bucket == false && var.bucket_name != "dbx-root-bucket") || var.create_bucket == true
      error_message = "If you are providing an S3 bucket please change \"var.bucket_name\" to a non-default value."
    }
  }
}

############################## Network Config ###################################

// Properly configure the VPC and subnets for Databricks within your AWS account.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_networks
resource "databricks_mws_networks" "nw" {
  account_id         = var.dbx_account_id
  network_name       = var.prefix != null ? "${var.prefix}-${var.dbx_network_name}" : var.dbx_network_name
  security_group_ids = var.security_group_ids
  subnet_ids         = var.vpc_subnet_ids
  vpc_id             = var.vpc_id
}


resource "time_sleep" "wait" {
  depends_on      = [aws_iam_policy_attachment.ipa]
  create_duration = "10s"
}

############################## Workplace Setup Config ###################################

// Set up the Databricks workspace to use the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_workspaces
resource "databricks_mws_workspaces" "ws" {
  aws_region               = var.region
  account_id               = var.dbx_account_id
  workspace_name           = var.prefix != null ? "${var.prefix}-${var.dbx_workspace_name}" : var.dbx_workspace_name
  credentials_id           = databricks_mws_credentials.cr.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.sc.storage_configuration_id
  network_id               = databricks_mws_networks.nw.network_id
}

################ Global Init Script ###########################
resource "databricks_global_init_script" "intel_optimized_script" {
  name    = "Intel Optimized ML-AI Init Script"
  enabled = true
  content_base64 = base64encode(<<-EOT
    #!/bin/bash
    pip install --upgrade pip
    pip install intel-tensorflow==2.11.0
    pip install scikit-learn-intelex
    EOT
  )
  provider = databricks.workspace
  depends_on = [
    databricks_mws_workspaces.ws
  ]
}
#### END



