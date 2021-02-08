resource "aws_api_gateway_rest_api" "apilambda" {
  name = "InventoryAPI"
  description = "This the API for inventory"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "inventoryresource" {
  rest_api_id = aws_api_gateway_rest_api.apilambda.id
  parent_id = aws_api_gateway_rest_api.apilambda.root_resource_id
  path_part = "inventory"
}

resource "aws_api_gateway_method" "inventorymethod" {
  rest_api_id = aws_api_gateway_rest_api.apilambda.id
  resource_id = aws_api_gateway_resource.inventoryresource.id
  http_method = "ANY"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "inventoryintegration" {
  rest_api_id = aws_api_gateway_rest_api.apilambda.id
  resource_id = aws_api_gateway_method.inventorymethod.resource_id
  http_method = aws_api_gateway_method.inventorymethod.http_method


  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.lambda_api.invoke_arn
}

resource "aws_api_gateway_deployment" "inventorydeploy" {
   depends_on = [
     aws_api_gateway_integration.inventoryintegration
   ]

   rest_api_id = aws_api_gateway_rest_api.apilambda.id
   stage_name  = "api"
}