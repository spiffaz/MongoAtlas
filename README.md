# MongoDB Atlas Terraform Module

This Terraform module helps you create and manage MongoDB Atlas projects, databases, users, and integrates with Datadog for monitoring. It simplifies the configuration of MongoDB Atlas resources, allowing you to define them as code.

## Prerequisites

Before using this module, ensure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- MongoDB Atlas API public and private keys.
- MongoDB Atlas organization ID.
- AWS account ID (for network peering).
- Datadog API key (if enabling Datadog integration).

## Usage

Create a `main.tf` file in your Terraform project and add the following code:

```hcl
module "mongodb_atlas" {
  source = "./modules/mongodb_atlas"

  projectName     = var.projectName
  default_tags    = var.default_tags
  datadog_region  = var.datadog_region
  aws_region      = var.aws_region
  aws_vpc_cidr    = var.aws_vpc_cidr
  datadog_api_key = var.datadog_api_key 

  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key
  mongodb_atlas_org_id      = var.mongodb_atlas_org_id

  aws_account_id = var.aws_account_id

  mongodb_atlas_accesslistip = var.mongodb_atlas_accesslistip

  enable_network_peering     = var.enable_network_peering     # Optionally enable network peering
  enable_datadog_integration = var.enable_datadog_integration # Optionally enable Datadog integration
}
```

In the example above, replace `"./modules/mongodb_atlas"` with the actual source path of your MongoDB Atlas Terraform module. Customize the module configuration and other variables as needed.

## Example Configuration

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

module "database" {
  source                    = "./database"
  project_id                = module.project.project_id
  database_name             = "test-database" # The name can only contain ASCII letters, numbers, and hyphens
  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key
}

module "user" {
  source                    = "./user"
  project_id                = module.project.project_id
  mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key
}

module "datadog_integration" {
  source                     = "./datadog_integration"
  project_id                 = module.project.project_id
  enable_datadog_integration = var.enable_datadog_integration
  datadog_api_key            = var.datadog_api_key
  datadog_region             = var.datadog_region
  mongodb_atlas_api_pub_key  = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key  = var.mongodb_atlas_api_pri_key
}

module "aws_resources" {
  source          = "../aws_resources"
  aws_region      = var.aws_region
  aws_vpc_cidr    = var.aws_vpc_cidr
  aws_subnet_cidr = "10.0.0.0/24" # change to variable after tests
  default_tags           = var.default_tags
  enable_network_peering = var.enable_network_peering
}

output "connection_strings" {
  value = module.database.connection_strings
}

output "db_user" {
  description = "Database user id!"
  value       = module.user.user_id
}

output "db_user_password" {
  description = "Database password. Do not share!"
  sensitive   = true
  value       = module.user.user_password
}

output "mongo_vpc_id" {
  value = module.project.mongo_container_vpc
}

output "datadog_integration_id" {
  description = "The ID of the Datadog integration"
  value       = var.enable_datadog_integration ? module.datadog_integration.datadog_integration_id : null
}
```

In this example, we have used multiple modules to create MongoDB Atlas resources, configure network peering, and integrate with Datadog for monitoring.

## Variables

- `enable_datadog_integration`: Set to true to enable Datadog integration.
- `mongodb_atlas_api_pub_key`: MongoDB Atlas API public key.
- `mongodb_atlas_api_pri_key`: MongoDB Atlas API private key.
- `mongodb_atlas_org_id`: MongoDB Atlas organization ID.
- `aws_account_id`: AWS

 account ID.
- `mongodb_atlas_accesslistip`: IP addresses/cidr ranges allowed to access the database.
- `projectName`: The MongoDB Atlas project name to be created.
- `default_tags`: Map of default tags to apply to resources.
- `enable_network_peering`: Set to true to enable network peering with AWS resources.
- `aws_region`: Region AWS resources would be deployed in.
- `aws_vpc_cidr`: CIDR block for AWS VPC.
- `datadog_region`: Datadog region.
- `datadog_api_key`: Datadog API Key.

## Outputs

- `connection_strings`: Connection strings for MongoDB Atlas clusters.
- `db_user`: Database user ID.
- `db_user_password`: Database user password (sensitive, do not share).
- `mongo_vpc_id`: The ID of the MongoDB Atlas container VPC.
- `datadog_integration_id`: The ID of the Datadog integration (if enabled).

**Note:** Ensure that you have valid MongoDB Atlas API keys, Datadog API key, and other required configurations before using this module.

For more information on MongoDB Atlas, Datadog, and Terraform, refer to the respective documentation:

- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [Datadog Documentation](https://docs.datadoghq.com/)
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
