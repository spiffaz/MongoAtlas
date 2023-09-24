# AWS Resources Terraform Module

The AWS Resources Terraform module simplifies the creation and management of AWS VPC resources, including VPC, Internet Gateway, Subnet, and Security Group. This module is designed to be used within your Terraform project to define AWS network resources as code.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS credentials configured using `aws configure`.

## Usage

To use this module, create a `main.tf` file in your Terraform project and add the following code:

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
  enable_network_peering = true  # Set to true to enable network peering with AWS resources.

  # Customize other variables if needed.
}
```

Replace `"modules/aws_resources"` with the actual source path to your AWS Resources Terraform module. Customize the `enable_network_peering` variable and other module configurations as required.

## Example Configuration

```hcl
resource "aws_vpc" "primary" {
  count                = var.enable_network_peering ? 1 : 0
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.default_tags
}

resource "aws_internet_gateway" "primary" {
  count  = var.enable_network_peering ? 1 : 0
  vpc_id = aws_vpc.primary[count.index].id

  tags = var.default_tags
}

resource "aws_subnet" "az1" {
  count                   = var.enable_network_peering ? 1 : 0
  vpc_id                  = aws_vpc.primary[count.index].id
  cidr_block              = var.aws_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = var.default_tags
}

resource "aws_security_group" "primary_default" {
  count       = var.enable_network_peering ? 1 : 0
  name_prefix = "default-"
  description = "Default security group for all instances in ${aws_vpc.primary[count.index].id}"
  vpc_id      = aws_vpc.primary[count.index].id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary[count.index].cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.default_tags
}
```

In this example, we are defining AWS VPC resources using the AWS Resources Terraform module. Customize the module configuration and other variables according to your project's requirements.

## Variables

- `enable_network_peering`: Set to true to enable network peering with AWS resources.

Additional variables are available for customizing the VPC, subnet, and security group configurations.

## Outputs

- `aws_vpc_id`: The ID of the AWS VPC.
- `aws_internet_gateway_id`: The ID of the AWS Internet Gateway.
- `aws_subnet_id`: The ID of the AWS Subnet.
- `aws_security_group_id`: The ID of the AWS Security Group.

**Note:** Ensure that you have valid AWS credentials and other required configurations before using this module.