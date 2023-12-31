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
  # Take these out and store as environment variables or secrets

}

module "datadog_integration" {
  source = "../../modules/mongodb_atlas/datadog_integration" # Replace with the actual source of your module.

  enable_datadog_integration = true
  project_id                 = var.project_id
  datadog_api_key            = var.datadog_api_key
  datadog_region             = var.datadog_region
}

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = module.datadog_integration.datadog_integration_id
}

variable "enable_datadog_integration" {
  description = "Set to true to enable Datadog integration."
  default     = false
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

variable "datadog_api_key" {
  description = "Datadog API Key"
}

variable "datadog_region" {
  description = "Datadog region"
}
