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

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_instance_size_name = "M0"
  provider_region_name        = "US_EAST_1"

  # Customize other cluster settings as needed.

  tags {
    key   = "Team"
    value = "Infrastructure"
  }
}

output "connection_strings" {
  description = "Connection strings for MongoDB Atlas cluster"
  value       = mongodbatlas_cluster.my_cluster.connection_strings.0.standard_srv
}

variable "mongodb_atlas_api_pub_key" {
  type = string
}

variable "mongodb_atlas_api_pri_key" {
  type = string
}

variable "project_id" {
  description = "The MongoDB Atlas Project ID"
}

variable "database_name" {
  description = "The name of the MongoDB Atlas Database"
}
