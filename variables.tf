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


# project variables
variable "projectName" {
  description = "The atlas project name to be created"
  type        = string
  default     = "my_project"
}

variable "mongodb_atlas_accesslistip" {
  type        = string
  description = "IP addresses/ cidr ranges allowed to access the database"
}

variable "enable_mongodb_atlas_accesslist_security_group" {
  type        = bool
  description = "Restrict access to my atlas project to an AWS security group"
  default     = true
}

variable "mongodb_atlas_accesslist_security_group_id" {
  type        = string
  description = "ID of AWS security group with allowed access to the cluster"
  default     = "default_value"
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    team = "infrastructure"
  }
}

variable "is_collect_database_specifics_statistics_enabled" {
  type    = bool
  default = true
}

variable "is_data_explorer_enabled" {
  type    = bool
  default = true
}

variable "is_performance_advisor_enabled" {
  type    = bool
  default = true
}

variable "is_realtime_performance_panel_enabled" {
  type    = bool
  default = true
}

variable "is_schema_advisor_enabled" {
  type    = bool
  default = true
}

variable "maintenance_window_day_of_week" {
  type    = number
  default = 4
}

variable "maintenance_window_hour_of_day" {
  type    = number
  default = 2
}

# Enable or disable network peering
variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  type        = bool
  default     = true
}

variable "atlas_network_container_cidr_block" {
  description = "CIDR range of the Atlas netowrk container"
  type        = string
  default     = "10.8.0.0/21"
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
  type        = bool
  default     = false
}

variable "datadog_api_key" {
  type    = string
  default = "default_value"
}

# Database variables
variable "database_name" {
  description = "The name of the database to be created. The name can only contain ASCII letters, numbers, and hyphens"
  type        = string
  default     = "test-database"
}

variable "atlas_provider_name" {
  description = "provider to be used in creating atlas cluster"
  type        = string
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
  default     = "6.0"
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

# User configuration

variable "username" {
  description = "The username for the MongoDB Atlas user"
  type        = string
  default     = "Admin"
}

variable "auth_database_name" {
  description = "Authentication database"
  type        = string
  default     = "admin"
}

variable "database_role_name" {
  description = "Role to assign to database user"
  type        = string
  default     = "atlasAdmin"
}

variable "database_name_to_give_access" {
  description = "Database to give access to"
  type        = string
  default     = "admin"
}

variable "user_password_length" {
  description = "Length of generated password"
  type        = number
  default     = 16
}

variable "allow_special_characters" {
  description = "Allow special characters in password?"
  type        = bool
  default     = false
}