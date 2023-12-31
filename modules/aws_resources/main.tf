terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}

resource "aws_vpc" "primary" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.default_tags
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id

  tags = var.default_tags
}

resource "aws_subnet" "az1" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = var.aws_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}a"

  tags = var.default_tags
}

resource "aws_security_group" "primary_default" {
  description = "Default security group for all instances in ${aws_vpc.primary.id}"
  vpc_id      = aws_vpc.primary.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary.cidr_block]
    description = "Allow ssh"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.primary.cidr_block]
    description = "Allow external traffic"
  }

  tags = var.default_tags
}


# attach security group to a resource
resource "aws_network_interface" "test" {
  subnet_id       = aws_subnet.az1.id
  security_groups = [aws_security_group.primary_default.id]
  depends_on      = [aws_subnet.az1]
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.primary.id
}

# VPC Flow logs

# KMS key for CloudWatch Log Group encryption
resource "aws_kms_key" "log_group_key_a" {
  description             = "KMS key for CloudWatch Log Group encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_kms_key_policy" "example" {
  key_id = aws_kms_key.log_group_key_a.id
  policy = jsonencode({
    Id = "example"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}



resource "aws_cloudwatch_log_group" "example" {
  name              = "my_vpc_log_group"
  depends_on        = [aws_kms_key.log_group_key_a]
  retention_in_days = 365
  kms_key_id        = aws_kms_key.log_group_key_a.arn
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "example" {
  name   = "example"
  role   = aws_iam_role.example.id
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_flow_log" "example" {
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.primary.id
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [aws_cloudwatch_log_group.example.arn]
  }
}