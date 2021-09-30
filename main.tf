

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

# Module: Security_group
module "inventory_securitygroup" {
    source                  = "./securitygroup_module"
    vpc_id                  =  module.inventory_vpc.vpc_id
    cidr_blocks             = [module.inventory_vpc.vpc_cidr]
    SG_NAME                 = "rdssg"
}

module "inventory_rds" {
    source                  = "./rds_module"
    subnet_ids              = [module.inventory_vpc.subnet_ids]
    availability_zone       = module.inventory_vpc.subnet_availability_zone
    vpc_security_group_ids  = [module.inventory_securitygroup.security_group_ids]
}