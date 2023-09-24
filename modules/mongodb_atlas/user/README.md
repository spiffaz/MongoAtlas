# MongoDB Atlas User Terraform Module

The MongoDB Atlas User Terraform module simplifies the creation and management of MongoDB Atlas database users. It allows you to define MongoDB Atlas users as code, configure their access privileges, and generate random passwords.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- MongoDB Atlas API public and private keys.
- A MongoDB Atlas project ID where the user will be created.

**Note:** For security reasons, always store your sensitive keys and credentials, such as MongoDB Atlas API keys, as environment variables or secrets within your CI/CD tool.

## Usage

To use this module, create a `main.tf` file in your Terraform project and add the following code:

```hcl
module "user" {
  source                       = "./user"
  project_id                   = module.project.project_id
  mongodb_atlas_api_pub_key    = var.mongodb_atlas_api_pub_key
  mongodb_atlas_api_pri_key    = var.mongodb_atlas_api_pri_key
  username                     = var.username
  auth_database_name           = var.auth_database_name
  database_role_name           = var.database_role_name
  database_name_to_give_access = var.database_name_to_give_access
  user_password_length         = var.user_password_length
  allow_special_characters     = var.allow_special_characters
}
```

Replace `"./user"` with the actual source path of your MongoDB Atlas User Terraform module. Customize the module configuration and other variables as needed.

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

resource "mongodbatlas_database_user" "mongo_user" {
  username           = var.username
  password           = random_password.user_password.result
  project_id         = var.project_id
  auth_database_name = var.auth_database_name

  roles {
    role_name     = var.database_role_name
    database_name = var.database_name_to_give_access
  }
}

resource "random_password" "user_password" {
  length  = var.user_password_length
  special = var.allow_special_characters
}

output "user_id" {
  description = "The MongoDB Atlas User ID"
  value       = mongodbatlas_database_user.mongo_user.id
}

output "user_password" {
  description = "The password of the created user"
  value       = random_password.user_password.result
}
```

In this example, we are using the MongoDB Atlas User Terraform module to create a MongoDB Atlas user. Customize the module configuration and other variables according to your requirements.

## Variables

- `mongodb_atlas_api_pub_key`: MongoDB Atlas API public key.
- `mongodb_atlas_api_pri_key`: MongoDB Atlas API private key.
- `project_id`: The MongoDB Atlas Project ID where the user will be created.
- `username`: The username for the MongoDB Atlas user.
- `auth_database_name`: The authentication database.
- `database_role_name`: The role to assign to the database user.
- `database_name_to_give_access`: The database to give access to.
- `user_password_length`: The length of the generated password.
- `allow_special_characters`: Allow special characters in the generated password.

## Outputs

- `user_id`: The MongoDB Atlas User ID.
- `user_password`: The password of the created user.

**Note:** Ensure that you have valid MongoDB Atlas API keys and other required configurations before using this module.