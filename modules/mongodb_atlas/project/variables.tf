variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  default     = false
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
  default     = "us-east-1"
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