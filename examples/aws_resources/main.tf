terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}

module "aws_resources" {
  source                = "modules/aws_resources" # Replace with the source of your module.
  enable_network_peering = false                 # Set to true to enable network peering with AWS resources from mongo db atlas

  # Customize other variables as needed.
}

output "aws_vpc_id" {
  description = "The ID of the AWS VPC"
  value       = module.aws_resources.aws_vpc_id
}

output "aws_internet_gateway_id" {
  description = "The ID of the AWS Internet Gateway"
  value       = module.aws_resources.aws_internet_gateway_id
}

output "aws_subnet_id" {
  description = "The ID of the AWS Subnet"
  value       = module.aws_resources.aws_subnet_id
}

output "aws_security_group_id" {
  description = "The ID of the AWS Security Group"
  value       = module.aws_resources.aws_security_group_id
}
