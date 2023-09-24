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

# database configuration
variable "database_name" {
  description = "The name of the database to be created. The name can only contain ASCII letters, numbers, and hyphens"
  type        = string
  default     = "test-database"
}

variable "atlas_provider_name" {
  description = "provider to be used in creating atlas cluster"
  default     = "TENANT"
}

variable "atlas_backing_provider_name" {
  description = "backing provider for creating atlas cluser. used when TENANT is the main provider"
  type        = string
  default     = "AWS"
}

variable "provider_instance_size_name" {
  description = "The size of the Atlas instance to be created"
  type        = string
  default     = "M0"
}

variable "provider_region_name" {
  description = "The region of the provider where the cluster will be provisioned"
  type        = string
  default     = "US_EAST_1"
}

variable "mongo_db_major_version" {
  description = "Mongo db version"
  type        = number
  default     = "5.0"
}

variable "auto_scaling_disk_gb_enabled" {
  description = "Is disk automatic scaling enabled?"
  type        = bool
  default     = true
}

variable "termination_protection_enabled" {
  description = "Database protection from deletion enabled?"
  type        = bool
  default     = false
}