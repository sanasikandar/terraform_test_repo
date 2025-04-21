# Terraform AWS VPC + EC2 + RDS Setup

This project uses Terraform modules to provision a secure and reusable infrastructure stack on AWS. It includes a custom VPC, an EC2 instance, and an RDS instance, with remote state management via S3 and state locking via DynamoDB.

## Modules Overview

### `modules/vpc`
- Creates a custom VPC with public and private subnets.
- Sets up an Internet Gateway (IGW) and a NAT Gateway for outbound traffic from private subnets.
- Configures route tables for public and private subnets.

### `modules/security_groups`
- Sets up security groups to control access to EC2 and RDS instances.
- Configures inbound/outbound rules for both EC2 and RDS to ensure secure communication.

### `modules/ec2`
- Launches an EC2 instance in a public subnet.
- Associates security groups and key pair.
- Configures necessary tags.

### `modules/rds`
- Deploys an RDS instance in private subnets.
- Attaches the necessary DB security group.
- Configures the database instance.

## Prerequisites

Before using this configuration, ensure you have the following:

- Terraform v1.3+ installed.
- AWS CLI configured with access keys and permissions for VPC, EC2, RDS, S3, and DynamoDB.
- An S3 bucket and DynamoDB table for remote state management:
  
  To create the remote state backend, run the following commands:
  ```bash
  aws s3api create-bucket --bucket my-terraform-state-bucket --region us-east-1
  aws dynamodb create-table \
      --table-name terraform-locks \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --billing-mode PAY_PER_REQUEST
## How To Use
1. Clone the Repository
Clone the repository to your local machine:
 git clone https://github.com/sanasikandar/terraform_test_repo.git
 cd terraform_test_repo
2. Initialize Terraform
  terraform init
  # This will set up the remote backend (S3 and DynamoDB) and download the necessary providers.
3. Review or Customize Variables
  # Edit terraform.tfvars or pass values via -var flags.
4. Apply the Configuration
   terraform apply


