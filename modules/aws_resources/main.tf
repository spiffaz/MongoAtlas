terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}

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