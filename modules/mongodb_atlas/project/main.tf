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

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true
}

resource "mongodbatlas_project_ip_access_list" "my_ipaddress" {
  project_id = mongodbatlas_project.mongo_project.id
  ip_address = var.mongodb_atlas_accesslistip
  comment    = "Allowed IP addresses"
}

resource "mongodbatlas_maintenance_window" "maintenance_window" {
  project_id  = mongodbatlas_project.mongo_project.id
  day_of_week = 4 # make configurable after tests
  hour_of_day = 2 # make configurable after tests
}

resource "mongodbatlas_network_container" "mongo_container" {
  count            = var.enable_network_peering ? 1 : 0
  project_id       = mongodbatlas_project.mongo_project.id
  atlas_cidr_block = "10.8.0.0/21" # make configurable after tests
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