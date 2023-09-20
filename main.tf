terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.4.6"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
  required_version = ">= 1.5"
}

provider "mongodbatlas" {
  public_key  = local.mongodb_atlas_api_pub_key
  private_key = local.mongodb_atlas_api_pri_key
}

# Create a Project
resource "mongodbatlas_project" "my_project" {
  name   = var.projectName
  org_id = local.mongodb_atlas_org_id
}

# Create a Shared Tier Cluster
resource "mongodbatlas_advanced_cluster" "my_cluster" {
  project_id              = mongodbatlas_project.my_project.id
  name                    = "atlasClusterName" # change to var
  cluster_type = "REPLICASET" # default to replicaset, consider sharded
  provider_name = "AWS"
  backup_enabled = "true"
  #disk_size_gb = ""
  mongo_db_major_version = "4.4"
  auto_scaling_disk_gb_enabled = "false"

  replication_specs {
    region_configs {
      electable_specs {
        instance_size = "M10"
        node_count    = 3
        #ebs_volume_type = "STANDARD" # "PROVISIONED"
      }
      analytics_specs {
        instance_size = "M10"
        node_count    = 1
      }
      provider_name = "AWS"
      priority      = 7
      region_name   = "US_EAST_1"
    }
    region_configs { 
      electable_specs {
        instance_size = "M10"
        node_count    = 2
      }
      analytics_specs {
        instance_size = "M10"
        node_count    = 1
      }
      provider_name = "AWS"
      priority      = 6
      region_name   = "US_EAST_2"
    }
  }
   labels {
        key   = "Team"
        value = "Infrastructure"
  }
}

# Create an Atlas Admin Database User
resource "mongodbatlas_database_user" "my_user" {
  username           = local.mongodb_atlas_database_username
  password           = local.mongodb_atlas_database_user_password
  project_id         = mongodbatlas_project.my_project.id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

#
# Create an IP Accesslist
#
# can also take a CIDR block or AWS Security Group -
# replace ip_address with either cidr_block = "CIDR_NOTATION"
# or aws_security_group = "SECURITY_GROUP_ID"
#
resource "mongodbatlas_project_ip_access_list" "my_ipaddress" {
      project_id = mongodbatlas_project.my_project.id
      ip_address = local.mongodb_atlas_accesslistip
      comment    = "My IP Address"
}