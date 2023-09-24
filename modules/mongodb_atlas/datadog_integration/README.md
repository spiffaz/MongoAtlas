# Datadog Integration to MongoDB Atlas Terraform Module

This Terraform module facilitates the integration of MongoDB Atlas with Datadog, empowering you to monitor and gain insights into your MongoDB Atlas clusters using Datadog's comprehensive monitoring and analytics platform.

## Prerequisites

Before utilizing this module, ensure you have met the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) must be installed on your local machine or CI/CD environment.
- You should have access to MongoDB Atlas API public and private keys.
- Obtain a Datadog API key and specify the region where your Datadog account is hosted.

**Note**: For security reasons, always store your sensitive keys and credentials, such as MongoDB Atlas API keys and Datadog API keys, as environment variables or secrets within your CI/CD tool.

## Usage

1. **Clone the Repository**: Clone or download the repository containing this Terraform module to your local machine or reference it directly in your Terraform configuration.

2. **Create a `main.tf` File**: In your Terraform project directory, create a `main.tf` file (if it doesn't already exist) and add the following code to define and configure the Datadog integration with MongoDB Atlas:

   ```hcl
   terraform {
     required_providers {
       mongodbatlas = {
         source  = "mongodb/mongodbatlas"
         version = "1.12.1"
       }
     }
   }

   provider "mongodbatlas" {
     public_key  = var.mongodb_atlas_api_pub_key
     private_key = var.mongodb_atlas_api_pri_key
   }

   resource "mongodbatlas_third_party_integration" "datadog_integration" {
     count      = var.enable_datadog_integration ? 1 : 0
     project_id = var.project_id
     type       = "DATADOG"
     api_key    = var.datadog_api_key
     region     = var.datadog_region
   }

   output "datadog_integration_id" {
     description = "The ID of the Datadog integration"
     value       = var.enable_datadog_integration ? mongodbatlas_third_party_integration.datadog_integration[0].id : null
   }
   ```

   Customize the values of the variables according to your specific requirements.

3. **Define Terraform Configuration**: Create a `variables.tf` file (if it doesn't already exist) to define the input variables for your Datadog integration. Here's an example of the variables:

   ```hcl
   variable "enable_datadog_integration" {
     description = "Set to true to enable Datadog integration."
     default     = false
   }

   variable "mongodb_atlas_api_pub_key" {
     type = string
   }

   variable "mongodb_atlas_api_pri_key" {
     type = string
   }

   variable "project_id" {
     description = "The MongoDB Atlas Project ID"
   }

   variable "datadog_api_key" {
     description = "Datadog API Key"
   }

   variable "datadog_region" {
     description = "Datadog region"
   }
   ```

   Customize the default values and descriptions as needed for your use case.

4. **Initialize Terraform**: Run the following command to initialize Terraform and download the required providers:

   ```bash
   terraform init
   ```

5. **Apply Terraform Configuration**: Apply the Terraform configuration to create the Datadog integration with MongoDB Atlas:

   ```bash
   terraform apply
   ```

   Review the changes and confirm by typing `yes` when prompted.

6. **Access Outputs**: After the Terraform apply is successful, you can access the output values, such as the Datadog integration ID, as needed for your applications:

   ```bash
   terraform output datadog_integration_id
   ```

7. **Clean Up**: To remove the Datadog integration and associated resources, you can use the `terraform destroy` command:

   ```bash
   terraform destroy
   ```

   Review the changes and confirm by typing `yes` when prompted.

Always follow best practices for securely storing sensitive keys and credentials. Store them as environment variables or secrets in your CI/CD tool to ensure the security of your infrastructure and resources.