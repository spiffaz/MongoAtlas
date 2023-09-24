variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  default     = false
}

variable "atlas_network_container_cidr_block" {
  description = "CIDR range of the Atlas netowrk container"
  type        = string
  default     = "10.8.0.0/21"
}

variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "mongodb_atlas_org_id" {
  type = string
}

variable "projectName" {
  description = "The atlas project name to be created"
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

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
}

variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type        = string
  description = "Region AWS resources would be deployed in"
  default     = "US-EAST-1"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "CIDR block for AWS VPC"
  default     = "10.0.0.0/24"
}

variable "aws_vpc_id" {
  type        = string
  description = "AWS VPC id to peer with"
}

variable "mongodb_atlas_accesslistip" {
  type        = string
  description = "IP addresses/ cidr ranges allowed to access the database"
}

variable "enable_mongodb_atlas_accesslist_security_group" {
  type        = bool
  description = "Restrict access to my atlas project to an AWS security group"
  default     = false
}

variable "mongodb_atlas_accesslist_security_group_id" {
  type    = string
  default = "default_value"
}