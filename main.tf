# main.tf

provider "aws" {
  region = var.region
}

# VPC Module: Create VPC and subnets
module "vpc" {
  source = "./modules/vpc"
  region = var.region
  tags   = local.tags
}

# Security Groups Module: Set up security groups for EC2 and RDS
module "security_groups" {
  source        = "./modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  ec2_cidr      = module.vpc.public_subnet_cidr_blocks[0]
  db_subnet_ids = module.vpc.private_subnet_ids
}

# EC2 Module: Create EC2 instance
module "ec2" {
  source             = "./modules/ec2"
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_groups.ec2_sg_id]
  tags               = local.tags
}

# RDS Module: Create RDS instance
module "rds" {
  source             = "./modules/rds"
  db_password        = var.db_password
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.rds_sg_id]
  tags               = local.tags
}

# Output EC2 Public IP and RDS Endpoint
output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
