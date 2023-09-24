# MongoDB Atlas Cluster Terraform Module

This Terraform module allows you to provision and manage a MongoDB Atlas cluster on the MongoDB Atlas cloud platform using infrastructure-as-code (IaC) principles.

## Prerequisites

Before using this Terraform module, ensure that you have the following prerequisites in place:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine or your CI/CD environment.
- MongoDB Atlas API public and private keys. These keys should be securely stored and managed as environment variables or secrets in your CI/CD tool to maintain security best practices.

## Usage

1. **Clone the Repository**: Clone or download the repository containing this Terraform module to your local machine or reference it directly in your Terraform configuration.

2. **Create a `main.tf` File**: In your Terraform project directory, create a `main.tf` file (if it doesn't already exist) and add the following code to define and configure the MongoDB Atlas cluster:

   ```hcl
   module "database" {
     source                    = "./database"
     project_id                = module.project.project_id
     database_name             = var.database_name
     mongodb_atlas_api_pub_key = var.mongodb_atlas_api_pub_key
     mongodb_atlas_api_pri_key = var.mongodb_atlas_api_pri_key

     atlas_provider_name            = var.atlas_provider_name
     atlas_backing_provider_name    = var.atlas_backing_provider_name
     provider_instance_size_name    = var.provider_instance_size_name
     provider_region_name           = var.provider_region_name
     mongo_db_major_version         = var.mongo_db_major_version
     auto_scaling_disk_gb_enabled   = var.auto_scaling_disk_gb_enabled
     termination_protection_enabled = var.termination_protection_enabled
   }
   ```

   Ensure that you customize the values of the variables according to your requirements.

3. **Define Terraform Configuration**: Create a `variables.tf` file (if it doesn't already exist) to define the input variables for your MongoDB Atlas cluster. Here's an example of the variables:

   ```hcl
   variable "mongodb_atlas_api_pub_key" {
     type = string
   }

   variable "mongodb_atlas_api_pri_key" {
     type = string
   }

   variable "project_id" {
     description = "The MongoDB Atlas Project ID"
   }

   variable "database_name" {
     description = "The name of the MongoDB Atlas Database"
   }

   variable "atlas_provider_name" {
     description = "Provider to be used in creating the Atlas cluster"
     default     = "TENANT"
   }

   variable "atlas_backing_provider_name" {
     description = "Backing provider for creating the Atlas cluster, used when TENANT is the main provider"
     type        = string
     default     = "AWS"
   }

   variable "provider_instance_size_name" {
     description = "The size of the Atlas instance to be created"
     type        = string
     default     = "M0"
   }

   variable "provider_region_name" {
     description = "The region of the provider where the cluster will be provisioned"
     type        = string
     default     = "US_EAST_1"
   }

   variable "mongo_db_major_version" {
     description = "MongoDB version"
     type        = number
     default     = 5.0
   }

   variable "auto_scaling_disk_gb_enabled" {
     description = "Is disk automatic scaling enabled?"
     type        = bool
     default     = true
   }

   variable "termination_protection_enabled" {
     description = "Database protection from deletion enabled?"
     type        = bool
     default     = false
   }
   ```

   Customize the default values and descriptions as needed for your use case.

4. **Initialize Terraform**: Run the following command to initialize Terraform and download the required providers:

   ```bash
   terraform init
   ```

5. **Apply Terraform Configuration**: Apply the Terraform configuration to create the MongoDB Atlas cluster:

   ```bash
   terraform apply
   ```

   Review the changes and confirm by typing `yes` when prompted.

6. **Access Outputs**: After the Terraform apply is successful, you can access the output values, such as connection strings and cluster ID, as needed for your applications:

   ```bash
   terraform output connection_strings
   terraform output cluster_id
   terraform output state_name
   terraform output mongo_uri
   ```

7. **Clean Up**: To tear down the MongoDB Atlas cluster and associated resources, you can use the `terraform destroy` command:

   ```bash
   terraform destroy
   ```

   Review the changes and confirm by typing `yes` when prompted.

Remember to keep your MongoDB Atlas API keys secure by storing them as environment variables or secrets in your CI/CD tool, as mentioned in the prerequisites section. This helps maintain the security of your infrastructure.