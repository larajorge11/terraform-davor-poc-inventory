output "base_url" {
  value = aws_api_gateway_deployment.inventorydeploy.invoke_url
}

output "source_arn" {
    value = aws_api_gateway_rest_api.apilambda.execution_arn
}