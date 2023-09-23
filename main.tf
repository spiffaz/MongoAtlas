provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_api_pub_key
  private_key = var.mongodb_atlas_api_pri_key
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

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

module "aws_resources" {
  source = "./modules/aws_resources"

  aws_region   = var.aws_region
  aws_vpc_cidr = var.aws_vpc_cidr
  default_tags = var.default_tags
}