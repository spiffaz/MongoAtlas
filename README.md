# Terraform MongoDB Atlas Project and AWS Resources

This Terraform project automates the deployment and configuration of a MongoDB Atlas project and associated AWS resources. It provides the ability to create and manage a MongoDB Atlas project, set up VPC peering with AWS, configure a maintenance window, and more.

## Prerequisites

Before you begin, ensure you have the following:

- Valid MongoDB Atlas API public and private keys.
- MongoDB Atlas organization ID.
- AWS access and secret keys.
- AWS VPC ID and CIDR block for VPC peering (if applicable).
- Datadog API key (if enabling Datadog integration).

## Usage

To use this project, follow these steps:

1. Create a `main.tf` file in your project directory and add the configuration provided in the project root directory `main.tf`. You can customize the variables as needed.

2. Initialize the Terraform project by running:

   ```shell
   terraform init
   ```

3. Review and validate the Terraform plan:

   ```shell
   terraform plan
   ```

4. Apply the configuration to create and configure the resources:

   ```shell
   terraform apply
   ```

5. After successful execution, Terraform will output valuable information like connection strings, VPC ID, and Datadog integration ID.

## Project Structure

The project is structured as follows:

- `main.tf`: The root configuration file that creates the MongoDB Atlas project, sets up VPC peering, and configures other resources.
- `modules/`: Directory containing reusable modules for MongoDB Atlas and AWS resources.
  - `mongodb_atlas/`: Module for MongoDB Atlas configuration.
  - `aws_resources/`: Module for AWS resources like VPC and security groups.
- `variables.tf`: Definitions for input variables.
- `outputs.tf`: Definitions for output variables.
- `terraform.tfvars`: A variable file to store sensitive information (not included in this repository).

## Variables

- MongoDB Atlas variables:
  - `mongodb_atlas_api_pub_key`: MongoDB Atlas API public key.
  - `mongodb_atlas_api_pri_key`: MongoDB Atlas API private key.
  - `mongodb_atlas_org_id`: MongoDB Atlas organization ID.

- AWS variables (if using VPC peering):
  - `aws_access_key`: AWS access key.
  - `aws_secret_key`: AWS secret key.
  - `aws_region`: AWS region for resource deployment.
  - `aws_vpc_cidr`: CIDR block for AWS VPC.
  
- Project variables:
  - `projectName`: Name of the MongoDB Atlas project to be created.
  - `mongodb_atlas_accesslistip`: IP addresses/cidr ranges allowed to access the database.
  - `default_tags`: Map of default tags to apply to resources.

- Network peering and Datadog integration variables:
  - `enable_network_peering`: Set to true to enable network peering with AWS resources.
  - `datadog_region`: Datadog region (if enabling Datadog integration).
  - `enable_datadog_integration`: Set to true to enable Datadog integration.
  - `datadog_api_key`: Datadog API key (if enabling Datadog integration).

## Outputs

- `connection_strings`: MongoDB Atlas connection strings.
- `db_user_password`: Database user password (sensitive).
- `mongo_vpc_id`: VPC ID of the MongoDB Atlas container (if network peering is enabled).
- `datadog_integration_id`: The ID of the Datadog integration (if enabled).

## Cleanup

To destroy the created resources and tear down the project, run:

```shell
terraform destroy
```

## Important Note

Please ensure that you keep sensitive information like API keys and access credentials secure and do not share them in your code repository. 