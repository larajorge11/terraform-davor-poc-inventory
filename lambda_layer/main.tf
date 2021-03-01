resource "aws_lambda_layer_version" "lambda_layer_cacheinstance" {
  filename = "CacheInstanceConnection-1.0.0.zip"
  layer_name = "CacheInstanceConnection"
  source_code_hash = filebase64sha256("CacheInstanceConnection-1.0.0.zip")
  compatible_runtimes = [ "java8" ]
}