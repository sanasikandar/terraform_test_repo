variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name for the VPC"
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "my-key"
}

variable "db_name" {
  description = "Name of the RDS database"
  default     = "mydb"
}

variable "db_username" {
  description = "Username for the RDS instance"
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS instance"
  sensitive   = true
}
