# Terraform MongoDB Atlas Project

This Terraform project automates the deployment and configuration of a MongoDB Atlas project and associated AWS resources. It provides the ability to create and manage a MongoDB Atlas project, set up VPC peering with AWS, configure a maintenance window, and more.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- **Valid MongoDB Atlas API Keys:**
  - `mongodb_atlas_api_pub_key`: Your MongoDB Atlas API public key.
  - `mongodb_atlas_api_pri_key`: Your MongoDB Atlas API private key.

- **MongoDB Atlas Organization ID:**
  - `mongodb_atlas_org_id`: The ID of your MongoDB Atlas organization.

- **AWS Access Keys:**
  - `aws_access_key`: Your AWS access key.
  - `aws_secret_key`: Your AWS secret key.

- **AWS VPC Configuration (if using VPC peering):**
  - `aws_region`: The AWS region where resources will be deployed.
  - `aws_vpc_cidr`: The CIDR block for your AWS VPC.

- **Datadog Integration (if enabling Datadog integration):**
  - `datadog_api_key`: Your Datadog API key.
  - `datadog_region`: The region for Datadog (e.g., "US").

## Usage

Follow these steps to use this Terraform project:

1. Create a `main.tf` file in your project directory and include the configuration provided in the project's root directory `main.tf`. You can customize the variables as needed.

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

5. After a successful execution, Terraform will output valuable information such as connection strings, VPC ID, and Datadog integration ID.

## Project Structure

This project is organized as follows:

- `main.tf`: The root configuration file that creates the MongoDB Atlas project, sets up VPC peering, and configures other resources.
- `modules/`: A directory containing reusable modules for MongoDB Atlas and AWS resources.
  - `mongodb_atlas/`: Module for MongoDB Atlas configuration.
  - `aws_resources/`: Module for AWS resources like VPC and security groups.
- `variables.tf`: Definitions for input variables.
- `outputs.tf`: Definitions for output variables.
- `terraform.tfvars`: A variable file to store sensitive information (not included in this repository).

## Configuration Variables

### MongoDB Atlas Variables

- `mongodb_atlas_api_pub_key`: MongoDB Atlas API public key.
- `mongodb_atlas_api_pri_key`: MongoDB Atlas API private key.
- `mongodb_atlas_org_id`: MongoDB Atlas organization ID.

### AWS Variables (for VPC Peering)

- `aws_access_key`: AWS access key.
- `aws_secret_key`: AWS secret key.
- `aws_region`: AWS region for resource deployment.
- `aws_vpc_cidr`: CIDR block for AWS VPC.

### Project Configuration Variables

- `projectName`: Name of the MongoDB Atlas project to be created.
- `mongodb_atlas_accesslistip`: IP addresses or CIDR ranges allowed to access the database.
- `default_tags`: A map of default tags to apply to resources.

### Network Peering and Datadog Integration Variables

- `enable_network_peering`: Set to `true` to enable network peering with AWS resources.
- `datadog_region`: Datadog region (if enabling Datadog integration).
- `enable_datadog_integration`: Set to `true` to enable Datadog integration.
- `datadog_api_key`: Datadog API key (if enabling Datadog integration).

### Other Configuration Variables

- Additional configuration variables for database settings, user authentication, and more are provided in the `main.tf` file.

## Outputs

After running `terraform apply`, Terraform will provide the following outputs:

- `connection_strings`: MongoDB Atlas connection strings.
- `db_user_password`: Database user password (sensitive).
- `mongo_vpc_id`: VPC ID of the MongoDB Atlas container (if network peering is enabled).
- `datadog_integration_id`: The ID of the Datadog integration (if enabled).

## Cleanup

To destroy the created resources and tear down the project, execute the following command:

```shell
terraform destroy
```

## Important Note

Please ensure that you keep sensitive information like API keys and access credentials secure and do not share them in your code repository. It is recommended to use Terraform's variable files or other secure methods to manage sensitive data.