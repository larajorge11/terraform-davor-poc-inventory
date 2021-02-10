resource "aws_s3_bucket" "main_bucket" {
  bucket = var.bucket
  force_destroy = true
}

resource "aws_s3_bucket_notification" "main_bucket_notification" {
  bucket = aws_s3_bucket.main_bucket.id
  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events = [ "s3:ObjectCreated:*" ]
  }

  depends_on = [ var.aws_lambda_permission_allow_bucket ]
}