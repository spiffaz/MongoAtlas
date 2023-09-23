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
  cluster_type = "REPLICASET" # default to replicaset, consider sharded

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_instance_size_name = "M0"
  provider_region_name        = "US_EAST_1"
  #backup_enabled               = "true"
  #mongo_db_major_version       = "4.4"
  #auto_scaling_disk_gb_enabled = "false"

  #cloud_backup      = true

  #replication_specs {
  #  num_shards = 3
  #regions_config {
  #  region_name     = "US_EAST_1"
  #  electable_nodes = 3
  #  priority        = 7
  #  read_only_nodes = 0
  #}
  #}

  tags {
    key   = "Team"
    value = "Infrastructure"
  }
}