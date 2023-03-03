variable "region" {
  type = string
  description = "AWS Region that will be used as a part of the deployment"
  default     = "us-east-2"
}

variable "dbx_account_password" {
  type = string
  description = "Account Login Password for the Databricks Account"
  default = "Blackdown2112!"
}

variable "dbx_account_username" {
  type        = string
  description = "Account Login Username for the Databricks Account"
  default = "shreejan.mistry@intel.com"
}

#f36297ba-ff38-4b4b-b5be-0a14d4b6d095"
variable "dbx_account_id" {
  type = string
  description = "Account Login Username for the Databricks Account"
  default = "f36297ba-ff38-4b4b-b5be-0a14d4b6d095"
}

