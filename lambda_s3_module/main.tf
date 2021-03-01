locals {
    lambda_function_name = var.lambda_function_name
    lambda_handler = var.lambda_handler
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_refresh.arn
  principal = "s3.amazonaws.com"
  source_arn = var.source_arn
}

resource "aws_lambda_function" "lambda_refresh" {
  depends_on        = [ var.null_resource_lambda_function, var.aws_s3_bucket_javabucket ]
	function_name     = local.lambda_function_name
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
	handler           = local.lambda_handler
	runtime           = var.runtime
	role              = var.aws_iam_role_arn
  memory_size       = 512
  timeout           = 10
  layers            = var.layers

  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  environment {
    variables = {
      "REDIS_HOST" = var.redis_host
      "REDIS_PORT" = var.redis_port
      "aws_access_key_id" = var.aws_access_key_id
      "aws_secret_access_key" = var.aws_secret_access_key
    }
  }
}