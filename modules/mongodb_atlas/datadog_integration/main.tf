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

resource "mongodbatlas_third_party_integration" "datadog_integration" {
  count      = var.enable_datadog_integration ? 1 : 0
  project_id = var.project_id
  type       = "DATADOG"
  api_key    = var.datadog_api_key
  region     = var.datadog_region
}
