provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_api_pub_key
  private_key = var.mongodb_atlas_api_pri_key
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
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

  mongodb_atlas_accesslistip                     = var.mongodb_atlas_accesslistip
  enable_mongodb_atlas_accesslist_security_group = var.enable_mongodb_atlas_accesslist_security_group
  mongodb_atlas_accesslist_security_group_id     = module.aws_resources.aws_security_group_id

  enable_network_peering     = var.enable_network_peering     # Optionally enable network peering
  enable_datadog_integration = var.enable_datadog_integration # Optionally enable Datadog integration

  # Project configuration
  is_collect_database_specifics_statistics_enabled = var.is_collect_database_specifics_statistics_enabled
  is_data_explorer_enabled                         = var.is_data_explorer_enabled
  is_performance_advisor_enabled                   = var.is_performance_advisor_enabled
  is_realtime_performance_panel_enabled            = var.is_realtime_performance_panel_enabled
  is_schema_advisor_enabled                        = var.is_schema_advisor_enabled

  maintenance_window_day_of_week = var.maintenance_window_day_of_week
  maintenance_window_hour_of_day = var.maintenance_window_hour_of_day

  atlas_network_container_cidr_block = var.atlas_network_container_cidr_block # If network peering is enabled

  # Database configuration
  database_name                  = var.database_name
  atlas_provider_name            = var.atlas_provider_name
  atlas_backing_provider_name    = var.atlas_backing_provider_name
  provider_instance_size_name    = var.provider_instance_size_name
  provider_region_name           = var.provider_region_name
  mongo_db_major_version         = var.mongo_db_major_version
  auto_scaling_disk_gb_enabled   = var.auto_scaling_disk_gb_enabled
  termination_protection_enabled = var.termination_protection_enabled

  # User configuration
  username                     = var.username
  auth_database_name           = var.auth_database_name
  database_role_name           = var.database_role_name
  database_name_to_give_access = var.database_name_to_give_access
  user_password_length         = var.user_password_length
  allow_special_characters     = var.allow_special_characters
}

module "aws_resources" {
  source = "./modules/aws_resources"

  aws_region   = var.aws_region
  aws_vpc_cidr = var.aws_vpc_cidr
  default_tags = var.default_tags
}