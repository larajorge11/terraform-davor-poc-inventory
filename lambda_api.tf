locals {
    lambda_function = "lambdaapi"
    lambda_handler_function = "com.poc.api.handler.function.InventoryFunction"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_api.function_name
  principal     = "apigateway.amazonaws.com"

  #source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
  source_arn = "${aws_api_gateway_rest_api.apilambda.execution_arn}/*/*"
}

resource "aws_lambda_function" "lambda_api" {
  depends_on        = [ null_resource.lambda_function, aws_s3_bucket.javabucket ]
	function_name     = local.lambda_function
  s3_bucket         = aws_s3_bucket.javabucket.id
  s3_key            = aws_s3_bucket_object.s3_javacode_object.key
	handler           = local.lambda_handler_function
	runtime           = "java8"
	role              = aws_iam_role.lambda-vpc-role.arn
  memory_size       = 512
  timeout           = 10

  vpc_config {
    subnet_ids          = [ aws_subnet.main-private-1.id ]
    security_group_ids  = [ aws_security_group.elastic_connection.id ]
  }

  environment {
    variables = {
      "REDIS_HOST" = aws_elasticache_cluster.davorredis.cache_nodes.0.address
      "REDIS_PORT" = aws_elasticache_cluster.davorredis.cache_nodes.0.port
    }
  }

}