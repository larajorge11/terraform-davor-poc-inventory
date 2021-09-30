

terraform {
  required_providers {
    aws = {
      source           = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  version = "3.22.0"
}

# Module: VPC, Subnets
module "inventory_vpc" {
  source                    = "./vpc_module"
  vpc_id                    = module.inventory_vpc.vpc_id
  vpc_cidr                  = "10.0.0.0/16"
  subnet_public_cidr        = "10.0.1.0/24"
  subnet_private_cidr       = "10.0.4.0/24"
  availability_zone         = "us-east-1a"
  service_name_vpc_endpoint = "com.amazonaws.us-east-1.s3"
}