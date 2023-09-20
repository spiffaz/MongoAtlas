variable "projectName" {
  description = "The atlas project name to be created"
  default     = "my_project"
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    team = "infrastructure"
  }
}

variable "aws_region" {
  type        = string
  description = "Region AWS resources would be deployed in"
  default     = "us-east-1"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "CIDR block for AWS VPC"
  default     = "10.0.0.0/24"
}