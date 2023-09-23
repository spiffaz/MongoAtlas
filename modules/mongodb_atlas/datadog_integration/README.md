# Datadog Integration to MongoDB Atlas Terraform Module

This Terraform module enables the integration of MongoDB Atlas with Datadog, allowing you to monitor and gain insights into your MongoDB Atlas clusters using Datadog's monitoring and analytics platform.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- MongoDB Atlas API public and private keys.
- Datadog API key and region.

## Usage

Create a `main.tf` file in your Terraform project and add the following code:

```hcl
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

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? mongodbatlas_third_party_integration.datadog_integration[0].id : null
}

