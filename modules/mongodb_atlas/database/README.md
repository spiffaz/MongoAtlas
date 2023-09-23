# MongoDB Atlas Cluster Terraform Module

This Terraform module provisions a MongoDB Atlas cluster on the MongoDB Atlas cloud platform. It allows you to define and manage MongoDB clusters in a programmatic and infrastructure-as-code (IaC) way.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- MongoDB Atlas API public and private keys.

## Usage

Create a `main.tf` file in your Terraform project and add the following code:


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
