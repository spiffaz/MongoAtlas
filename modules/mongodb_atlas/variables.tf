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

variable "mongodb_atlas_accesslistip" {
  type        = string
  description = "IP addresses/ cidr ranges allowed to access the database"
}

variable "projectName" {
  description = "The atlas project name to be created"
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    team = "infrastructure"
  }
}

# peering configuration
variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  default     = false
}

variable "aws_region" {
  type        = string
  description = "Region AWS resources would be deployed in"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "CIDR block for AWS VPC"
}

variable "datadog_region" {
  type        = string
  description = "Datadog region"
}


# datadog configuration
variable "enable_datadog_integration" {
  description = "Set to true to enable Datadog integration."
  default     = false
}

variable "datadog_api_key" {
  description = "Datadog API Key"
}

