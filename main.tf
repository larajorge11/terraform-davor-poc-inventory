# Module: Roles and Policies
module "inventory_iam" {
  source = "./iam_module"

  aws_iam_policy_name = "davor19890806_lambda_policy"
  aws_iam_role_name   = "davor19890806_lambda_role"

  aws_s3_bucket_javabucket  = module.inventory_s3_java.aws_s3_bucket_javabucket
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

# Module: Security_group
module "inventory_securitygroup" {
    source                  = "./securitygroup_module"
    vpc_id                  =  module.inventory_vpc.vpc_id
    cidr_blocks             = [module.inventory_vpc.vpc_cidr]
    SG_NAME                 = "sgelastic"
}

# Module: Instance (Testing purposes Elasticache)
module "inventory_instance" {
  source                    = "./instance_module"
  subnet_id                 = module.inventory_vpc.main-public-1
  vpc_security_group_ids    = module.inventory_securitygroup.ssh_connection_id
  aws_key_pair              = "davorkey"
}

# Module: Elasticache
module "inventory_elasticache" {
  source                    = "./elasticache_module"
  cluster_id                = "davoredis19890806"
  node_type                 = "cache.t2.micro"
  parameter_group_name      = "default.redis6.x"
  port                      = 6379
  subnet_ids                = [ module.inventory_vpc.subnet_ids ]
  security_group_ids        = [ module.inventory_securitygroup.security_group_ids ]            
}

# Module: API Gateway
module "inventory_api_gateway" {
  source                    = "./apigateway_module"
  apigw_name                = "InventoryAPI"
  description               = "This the API for inventory"
  resource                  = "inventory"
  deploy                    = "api"
  uri                       = module.inventory_lambda_api.aws_lambda_function_arn
}

# Module: Lambda API Gateway - Elasticache
module "inventory_lambda_api" {
    source                        = "./lambda_api_module"
    lambda_handler_function       = "com.poc.api.handler.function.InventoryFunction"
    lambdaapi_name                = "lambdaInventoryApi"
    source_arn                    = "${module.inventory_api_gateway.source_arn}/*/*"
    s3_bucket                     = module.inventory_s3_java.aws_s3_bucket_id
    s3_key                        = module.inventory_s3_java.aws_s3_bucket_object_key
    runtime                       = "java8"
    aws_iam_role_arn              = module.inventory_iam.aws_iam_role_arn
    subnet_ids                    = [ module.inventory_vpc.subnet_ids ]
    security_group_ids            = [ module.inventory_securitygroup.security_group_ids ]
    redis_host                    = module.inventory_elasticache.redis_host
    redis_port                    = module.inventory_elasticache.redis_port
    null_resource_lambda_function = module.inventory_null_resource.null_resource_lambda_function
    aws_s3_bucket_javabucket      = module.inventory_s3_java.aws_s3_bucket_javabucket
}

# Module: Lambda S3 - Elasticache
module "inventory_lambda_s3" {
    source                  = "./lambda_s3_module"
    lambda_function_name    = "lambdaelastic"
    lambda_handler          = "com.poc.csv.handler.InventoryRefresh"
    source_arn              = module.inventory_s3_data.source_arn
    s3_bucket                 = module.inventory_s3_java.aws_s3_bucket_id
    s3_key                    = module.inventory_s3_java.aws_s3_bucket_object_key
    runtime                   = "java8"
    aws_iam_role_arn          = module.inventory_iam.aws_iam_role_arn
    subnet_ids                = [ module.inventory_vpc.subnet_ids ]
    security_group_ids        = [ module.inventory_securitygroup.security_group_ids ]
    redis_host                = module.inventory_elasticache.redis_host
    redis_port                = module.inventory_elasticache.redis_port
    aws_access_key_id         = var.ACCESS_KEY
    aws_secret_access_key     = var.SECRET_ACCESS_KEY
    null_resource_lambda_function = module.inventory_null_resource.null_resource_lambda_function
    aws_s3_bucket_javabucket      = module.inventory_s3_java.aws_s3_bucket_javabucket
}

# Module: S3 Java package
module "inventory_s3_java" {
    source                    = "./s3_java_module"
    java_zip_filename         = "InventoryData-1.0.0-SNAPSHOT.zip"
    bucket                    = "pocinventory19890806-java-bucket"
    aws_s3_bucket_object_key  = "function/InventoryData-1.0.0-SNAPSHOT.zip"
    content_type              = "application/zip"
    
}

# Module: S3 Load Data
module "inventory_s3_data" {
    source                              = "./s3_data_module"
    bucket                              = "pocinventory19890806-src-bucket"
    lambda_function_arn                 = module.inventory_lambda_s3.aws_lambda_function_arn
    aws_lambda_permission_allow_bucket  = module.inventory_lambda_s3.aws_lambda_permission_allow_bucket
}

module "inventory_null_resource" {
  source = "./null_resource_module"
}