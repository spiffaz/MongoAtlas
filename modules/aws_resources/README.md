# AWS Resources Terraform Module

This Terraform module creates AWS VPC resources including VPC, Internet Gateway, Subnet, and Security Group based on the provided configuration.

For this to be used outside of the mongodb_atlas module, set enable_network_peering to true.

## Prerequisites

Before using this module, ensure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS credentials configured using `aws configure`.

## Usage

Create a `main.tf` file in your Terraform project and add the following code:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}

module "aws_resources" {
  source                = "modules/aws_resources" 
  enable_network_peering = true                 # Set to true to enable network peering with AWS resources.

  # Customize other variables if needed.
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
