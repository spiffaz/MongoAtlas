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