variable "lambda_function_name" {
  default = "lambdaelastic"
}

variable "lambda_handler" {
  default = "com.poc.csv.handler.InventoryRefresh"
}

variable "runtime" {
  default = "java8"
}

variable "source_arn" {}

variable "s3_bucket" {}

variable "s3_key" {}

variable "aws_iam_role_arn" {}

variable "subnet_ids" {}

variable "security_group_ids" {}

variable "redis_host" {}

variable "redis_port" {}

variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}

variable "null_resource_lambda_function" {}

variable "aws_s3_bucket_javabucket" {}

variable "layers" {}