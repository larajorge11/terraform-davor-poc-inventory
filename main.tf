terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.43.0"
    }
  }
  required_version = "1.0.0"
}

provider "aws" {
  region = var.aws_region
}

# Module: VPC, Subnets
module "inventory_vpc" {
  source                    = "./vpc_module"
  vpc_id                    = module.inventory_vpc.vpc_id
  vpc_cidr                  = "10.0.0.0/16"
  subnet_public_cidr        = "10.0.1.0/24"
  subnet_private_cidr       = "10.0.4.0/24"
  availability_zone         = "eu-west-2a"
  service_name_vpc_endpoint = "com.amazonaws.eu-west-2.s3"
}