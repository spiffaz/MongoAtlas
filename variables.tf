# access keys
variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "mongodb_atlas_org_id" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}


# project variables
variable "projectName" {
  description = "The atlas project name to be created"
  default     = "my_project"
}

variable "mongodb_atlas_accesslistip" {
  type        = string
  description = "IP addresses/ cidr ranges allowed to access the database"
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    team = "infrastructure"
  }
}

# Enable or disable network peering
variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  default     = false
}

# AWS Variables (if you use VPC peering)
variable "aws_region" {
  type        = string
  description = "Region AWS resources would be deployed in"
  default     = "us-east-1"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "CIDR block for AWS VPC"
  default     = "10.0.0.0/24"
}

variable "datadog_region" {
  type        = string
  description = "Datadog region"
  default     = "US"
}

# Enable or disable Datadog integration
variable "enable_datadog_integration" {
  description = "Set to true to enable Datadog integration."
  default     = false
}

variable "datadog_api_key" {
  type = string
}