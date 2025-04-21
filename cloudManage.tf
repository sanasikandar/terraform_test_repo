# Root Module - main.tf

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "vpc-ec2-rds/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  cidr_block = var.vpc_cidr
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_groups.web_sg_id]
  instance_type = var.ec2_instance_type
  key_name = var.key_name
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.db_sg_id]
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
