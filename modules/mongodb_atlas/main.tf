module "project" {
  source       = "./project"
  projectName  = var.projectName
  default_tags = var.default_tags

  mongodb_atlas_api_pub_key  = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key  = var.mongodb_atlas_api_pri_key
  mongodb_atlas_org_id       = var.mongodb_atlas_org_id
  aws_account_id             = var.aws_account_id
  aws_vpc_id                 = module.aws_resources.aws_vpc_id
  mongodb_atlas_accesslistip = var.mongodb_atlas_accesslistip

}

module "database" {
  source                    = "./database"
  project_id                = module.project.project_id
  database_name             = var.database_name
  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key

  atlas_provider_name            = var.atlas_provider_name
  atlas_backing_provider_name    = var.atlas_backing_provider_name
  provider_instance_size_name    = var.provider_instance_size_name
  provider_region_name           = var.provider_region_name
  mongo_db_major_version         = var.mongo_db_major_version
  auto_scaling_disk_gb_enabled   = var.auto_scaling_disk_gb_enabled
  termination_protection_enabled = var.termination_protection_enabled

}

module "user" {
  source                    = "./user"
  project_id                = module.project.project_id
  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key
}

module "datadog_integration" {
  source                     = "./datadog_integration"
  project_id                 = module.project.project_id
  enable_datadog_integration = var.enable_datadog_integration
  datadog_api_key            = var.datadog_api_key
  datadog_region             = var.datadog_region
  mongodb_atlas_api_pub_key  = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key  = var.mongodb_atlas_api_pri_key
}

module "aws_resources" {
  source                 = "../aws_resources"
  aws_region             = var.aws_region
  aws_vpc_cidr           = var.aws_vpc_cidr
  aws_subnet_cidr        = "10.0.0.0/24" # change to variable after tests
  default_tags           = var.default_tags
  enable_network_peering = var.enable_network_peering
}