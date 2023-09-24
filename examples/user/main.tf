# Define the MongoDB Atlas Project Module
module "mongodb_atlas_project" {
  source = "./mongodb_atlas_project" # Replace with the actual source path

  # Input Variables
  projectName = "my-atlas-project"
  default_tags = {
    environment = "production"
    owner       = "myteam"
  }
 # Take secrets and keys out and store as environment variables or secrets
  mongodb_atlas_api_pub_key  = "your-public-key"
  mongodb_atlas_api_pri_key  = "your-private-key"
  mongodb_atlas_org_id       = "your-org-id"
  aws_account_id             = "your-aws-account-id"
  aws_vpc_id                 = "your-aws-vpc-id"
  mongodb_atlas_accesslistip = "0.0.0.0/0" # Example IP range, please restrict this in production
  enable_network_peering     = true        # Enable network peering
}

# Output the MongoDB Atlas Project ID
output "project_id" {
  value = module.mongodb_atlas_project.project_id
}

# Output the MongoDB Atlas Container VPC ID
output "mongo_container_vpc" {
  value = module.mongodb_atlas_project.mongo_container_vpc
}
