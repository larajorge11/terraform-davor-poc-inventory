locals {
    lambda_function = var.lambdaapi_name
    lambda_handler_function = var.lambda_handler_function
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.source_arn
}

resource "aws_lambda_function" "lambda_api" {
  depends_on        = [ var.null_resource_lambda_function, var.aws_s3_bucket_javabucket ]
	function_name     = local.lambda_function
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
	handler           = local.lambda_handler_function
	runtime           = var.runtime
	role              = var.aws_iam_role_arn
  memory_size       = 512
  timeout           = 10

  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  environment {
    variables = {
      "REDIS_HOST" = var.redis_host
      "REDIS_PORT" = var.redis_port
    }
  }

}