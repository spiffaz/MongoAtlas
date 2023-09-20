terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.4.6"
    }
    aws = {
      source  = "hashicorp/aws"
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

resource "mongodbatlas_network_container" "test" {
  project_id       = mongodbatlas_project.my_project.id
  atlas_cidr_block = "10.8.0.0/21"
  provider_name    = "AWS"
  region_name      = "US_EAST_1"

  access_list {
    ip_address = local.mongodb_atlas_accesslistip # Replace with your public IP address
    comment    = "Allow public access"
  }
}

# Create a Shared Tier Cluster
resource "mongodbatlas_advanced_cluster" "my_cluster" {
  project_id     = mongodbatlas_project.my_project.id
  name           = "atlasClusterName" # change to var
  cluster_type   = "REPLICASET"       # default to replicaset, consider sharded
  provider_name  = "AWS"
  backup_enabled = "true"
  #disk_size_gb = ""
  mongo_db_major_version       = "4.4"
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
    #region_configs {
    #  electable_specs {
    #    instance_size = "M10"
    #    node_count    = 2
    #  }
    #  analytics_specs {
    #    instance_size = "M10"
    #    node_count    = 1
    #  }
    #  provider_name = "AWS"
    #  priority      = 6
    #  region_name   = "US_EAST_2"
    #}
  }
  maintenance_window {
    id = mongodbatlas_maintenance_window.maintenance_window.id
  }
  labels {
    key   = "Team"
    value = "Infrastructure"
  }
}

resource "mongodbatlas_maintenance_window" "maintenance_window" {
  project_id               = mongodbatlas_project.my_project.id
  day_of_week              = "MONDAY"
  start_hour_utc           = 2
  frequency_interval_hours = 168 # Weekly
}

# Create an Atlas Admin Database User
resource "mongodbatlas_database_user" "my_user" {
  username           = local.mongodb_atlas_database_username # change to generate random password
  password           = local.mongodb_atlas_database_user_password
  project_id         = mongodbatlas_project.my_project.id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
  scopes {
    name = "my_cluster"
    type = "CLUSTER"
  }
  labels {
    key   = "Team"
    value = "Infrastructure"
  }
  # aws_iam_type = "ROLE" # create a role and give admin permissions to that role
}

#resource "mongodbatlas_project_ip_access_list" "my_ipaddress" {
#  project_id = mongodbatlas_project.my_project.id
#  ip_address = local.mongodb_atlas_accesslistip #aws_security_group = "SECURITY_GROUP_ID" # change to aws security group
#  comment    = "Allowed IP addresses"
#}