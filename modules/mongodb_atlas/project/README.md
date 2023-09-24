# MongoDB Atlas Project Terraform Module

The MongoDB Atlas Project Terraform module simplifies the creation and configuration of a MongoDB Atlas project. It provides options for enabling various features such as Data Explorer, Performance Advisor, and Network Peering with AWS resources. This module allows you to define your MongoDB Atlas project as code.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- MongoDB Atlas API public and private keys.
- MongoDB Atlas organization ID.
- AWS account ID (if enabling network peering).
- Valid AWS VPC configurations (if enabling network peering).

**Note:** For security reasons, always store your sensitive keys and credentials, such as MongoDB Atlas API keys, as environment variables or secrets within your CI/CD tool.

## Usage

To use this module, create a `main.tf` file in your Terraform project and add the following code:

```hcl
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
```

Replace `"./project"` with the actual source path of your MongoDB Atlas Project Terraform module. Customize the module configuration and other variables as needed.

## Example Configuration

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

output "project_id" {
  description = "The MongoDB Atlas Project ID"
  value       = mongodbatlas_project.mongo_project.id
}

output "mongo_container_vpc" {
  description = "The VPC ID of the MongoDB Atlas container"
  value       = var.enable_network_peering ? mongodbatlas_network_container.mongo_container[0].vpc_id : null
}
```

In this example, we are using the MongoDB Atlas Project Terraform module and configuring various parameters and options for creating and configuring a MongoDB Atlas project. Customize the module configuration and other variables according to your project's needs.

## Variables

- `mongodb_atlas_api_pub_key`: MongoDB Atlas API public key.
- `mongodb_atlas_api_pri_key`: MongoDB Atlas API private key.
- `mongodb_atlas_org_id`: MongoDB Atlas organization ID.
- `projectName`: The MongoDB Atlas project name to be created.
- `default_tags`: Map of default tags to apply to resources.
- `aws_account_id`: AWS account ID.
- `mongodb_atlas_accesslistip`: IP addresses/cidr ranges allowed to access the database.
- `aws_region`: Region where AWS resources would be deployed.
- `aws_vpc_cidr`: CIDR block for AWS VPC.
- `aws_vpc_id`: AWS VPC ID to peer with.
- `enable_network_peering`: Set to true to enable network peering with AWS resources.

## Outputs

- `project_id`: The MongoDB Atlas Project ID.
- `mongo_container_vpc`: The VPC ID of the MongoDB Atlas container (if network peering is enabled).

**Note:** Ensure that you have valid MongoDB Atlas API keys and other required configurations before using this module.