variable "enable_network_peering" {
  description = "Set to true to enable network peering with AWS resources."
  default     = false
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to created AWS resources"
  default = {
    team = "infrastructure"
  }
}

variable "aws_region" {
  type        = string
  description = "Region for AWS resources"
  default     = "us-east-1"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "CIDR block for AWS VPC"
  default     = "10.0.0.0/24"
}

variable "aws_subnet_cidr" {
  type        = string
  description = "CIDR block for AWS Subnet"
  default     = "10.0.0.0/24"
}