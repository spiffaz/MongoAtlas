terraform {
  required_version = ">= 1.5"

  backend "remote" {
    organization = "spiffaz"
    workspaces {
      name = "atlas"
    }
  }

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.12.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}