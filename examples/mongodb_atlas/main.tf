terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.12.1"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_api_pub_key
  private_key = var.mongodb_atlas_api_pri_key
}

module "mongodb_atlas" {
  source = "./modules/mongodb_atlas"

  projectName     = var.projectName
  default_tags    = var.default_tags
  datadog_region  = var.datadog_region
  aws_region      = var.aws_region
  aws_vpc_cidr    = var.aws_vpc_cidr
  datadog_api_key = var.datadog_api_key 

  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key
  mongodb_atlas_org_id      = var.mongodb_atlas_org_id

  aws_account_id = var.aws_account_id

  mongodb_atlas_accesslistip = var.mongodb_atlas_accesslistip

  enable_network_peering     = var.enable_network_peering     # Optionally enable network peering
  enable_datadog_integration = var.enable_datadog_integration # Optionally enable Datadog integration
}

module "aws_resources" {
  source          = "../aws_resources"
  aws_region      = var.aws_region
  aws_vpc_cidr    = var.aws_vpc_cidr
  aws_subnet_cidr = "10.0.0.0/24" # change to variable after tests
  default_tags           = var.default_tags
  enable_network_peering = var.enable_network_peering
}

output "connection_strings" {
  value = module.mongodb_atlas.connection_strings
}

output "db_user" {
  description = "Database user id!"
  value       = module.mongodb_atlas.db_user
}

output "db_user_password" {
  description = "Database password. Do not share!"
  sensitive   = true
  value       = module.mongodb_atlas.db_user_password
}

output "mongo_vpc_id" {
  value = module.mongodb_atlas.mongo_container_vpc
}

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? module.mongodb_atlas.datadog_integration_id : null
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

variable "aws_account_id" {
  type = string
}

variable "mongodb_atlas_accesslistip" {
  type        = string
  description = "IP addresses/cidr ranges allowed to access the database"
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
