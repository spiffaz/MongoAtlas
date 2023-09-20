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
}

resource "mongodbatlas_network_peering" "aws-atlas" {
  accepter_region_name   = local.aws_region
  project_id             = mongodbatlas_project.my_project.id
  container_id           = mongodbatlas_network_container.test.id
  provider_name          = "AWS"
  route_table_cidr_block = aws_vpc.primary.cidr_block
  vpc_id                 = aws_vpc.primary.id
  aws_account_id         = local.aws_account_id
}

# Create a Shared Tier Cluster
resource "mongodbatlas_cluster" "my_cluster" {
  project_id                   = mongodbatlas_project.my_project.id
  name                         = "atlasClusterName" # change to var
  cluster_type                 = "REPLICASET"       # default to replicaset, consider sharded
  provider_name                = "AWS"
  provider_instance_size_name  = "M40"
  backup_enabled               = "true"
  mongo_db_major_version       = "4.4"
  auto_scaling_disk_gb_enabled = "false"

  replication_specs {
    num_shards = 3
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  labels {
    key   = "Team"
    value = "Infrastructure"
  }
}

resource "mongodbatlas_maintenance_window" "maintenance_window" {
  project_id  = mongodbatlas_project.my_project.id
  day_of_week = 4 # Wednesday
  hour_of_day = 2 # 2 am
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

resource "mongodbatlas_project_ip_access_list" "my_ipaddress" {
  project_id = mongodbatlas_project.my_project.id
  ip_address = local.mongodb_atlas_accesslistip #aws_security_group = "SECURITY_GROUP_ID" # change to aws security group
  comment    = "Allowed IP addresses"
}