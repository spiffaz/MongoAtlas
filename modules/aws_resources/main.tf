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
    description = "Allow ssh"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow external traffic"
  }

  tags = var.default_tags
}

# attach security group to a resource
resource "aws_network_interface" "test" {
  count           = var.enable_network_peering ? 1 : 0
  subnet_id       = "aws_subnet.az1.id"
  security_groups = [aws_security_group.primary_default[count.index].id]
}

# Disable inbound and outbound on default security group

resource "aws_security_group_rule" "default_egress" {
  count             = var.enable_network_peering ? 1 : 0
  type              = "egress"
  description       = "block all traffic"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_default_security_group.default[count.index].id
}

resource "aws_security_group_rule" "default_ingress" {
  count             = var.enable_network_peering ? 1 : 0
  type              = "ingress"
  description       = "block all traffic"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_default_security_group.default[count.index].id
}

resource "aws_default_security_group" "default" {
  count  = var.enable_network_peering ? 1 : 0
  vpc_id = aws_vpc.primary[count.index].id

}

# VPC Flow logs

resource "aws_cloudwatch_log_group" "example" {
  count = var.enable_network_peering ? 1 : 0
  name  = "log_group"
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
  count           = var.enable_network_peering ? 1 : 0
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example[count.index].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.primary[count.index].id
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

    resources = ["*"]
  }
}