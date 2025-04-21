# For Remote State
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "vpc-ec2-rds/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
