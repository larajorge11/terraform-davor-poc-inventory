variable "lambda_handler_function" {
  default = "com.poc.api.handler.function.InventoryFunction"
}

variable "lambdaapi_name" {
  default = "lambdaapi"
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

variable "null_resource_lambda_function" {}

variable "aws_s3_bucket_javabucket" {}

variable "layers" {}