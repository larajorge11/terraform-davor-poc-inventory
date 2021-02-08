resource "aws_s3_bucket" "main_bucket" {
  bucket = "${var.ENV_NAME}-src-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_notification" "main_bucket_notification" {
  bucket = aws_s3_bucket.main_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_refresh.arn
    events = [ "s3:ObjectCreated:*" ]
  }

  depends_on = [ aws_lambda_permission.allow_bucket ]
}