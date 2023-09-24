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

resource "mongodbatlas_cluster" "my_cluster" {
  project_id   = var.project_id
  name         = var.database_name
  cluster_type = "REPLICASET"

  provider_name                  = var.atlas_provider_name
  backing_provider_name          = var.atlas_backing_provider_name
  provider_instance_size_name    = var.provider_instance_size_name
  provider_region_name           = var.provider_region_name
  mongo_db_major_version         = var.mongo_db_major_version
  auto_scaling_disk_gb_enabled   = var.auto_scaling_disk_gb_enabled
  termination_protection_enabled = var.termination_protection_enabled

  tags {
    key   = "Team"
    value = "Infrastructure"
  }
}