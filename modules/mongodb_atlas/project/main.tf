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

resource "mongodbatlas_project" "mongo_project" {
  name   = var.projectName
  org_id = var.mongodb_atlas_org_id

  is_collect_database_specifics_statistics_enabled = var.is_collect_database_specifics_statistics_enabled
  is_data_explorer_enabled                         = var.is_data_explorer_enabled
  is_performance_advisor_enabled                   = var.is_performance_advisor_enabled
  is_realtime_performance_panel_enabled            = var.is_realtime_performance_panel_enabled
  is_schema_advisor_enabled                        = var.is_schema_advisor_enabled
}

resource "mongodbatlas_project_ip_access_list" "my_ipaddress" {
  project_id = mongodbatlas_project.mongo_project.id
  ip_address = var.mongodb_atlas_accesslistip
  comment    = "Allowed IP addresses"
}

# Allow access to the project from an AWS security group
resource "mongodbatlas_project_ip_access_list" "my_aws_security_group" {
  count              = var.enable_mongodb_atlas_accesslist_security_group ? 1 : 0
  project_id         = mongodbatlas_project.mongo_project.id
  aws_security_group = var.mongodb_atlas_accesslist_security_group_id
  comment            = "Allowed Security groups"
  depends_on         = [mongodbatlas_network_peering.aws-atlas]
}

resource "mongodbatlas_maintenance_window" "maintenance_window" {
  project_id  = mongodbatlas_project.mongo_project.id
  day_of_week = var.maintenance_window_day_of_week
  hour_of_day = var.maintenance_window_hour_of_day
}

resource "mongodbatlas_network_container" "mongo_container" {
  count            = var.enable_network_peering ? 1 : 0
  project_id       = mongodbatlas_project.mongo_project.id
  atlas_cidr_block = var.atlas_network_container_cidr_block
  provider_name    = "AWS"
  region_name      = var.aws_region
}

resource "mongodbatlas_network_peering" "aws-atlas" {
  count                  = var.enable_network_peering ? 1 : 0
  accepter_region_name   = var.aws_region
  project_id             = mongodbatlas_project.mongo_project.id
  container_id           = element(mongodbatlas_network_container.mongo_container[*].id, 0)
  provider_name          = "AWS"
  route_table_cidr_block = var.aws_vpc_cidr
  vpc_id                 = var.aws_vpc_id
  aws_account_id         = var.aws_account_id
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  count                     = var.enable_network_peering ? 1 : 0
  vpc_peering_connection_id = mongodbatlas_network_peering.aws-atlas[0].connection_id #element(mongodbatlas_network_peering.aws-atlas[0].connection_id, 0)
  auto_accept               = true
}