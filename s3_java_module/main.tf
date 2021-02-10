
locals {
    java_zip_filename = var.java_zip_filename
}

resource "aws_s3_bucket" "javabucket" {
  bucket = var.bucket
  force_destroy = true
}

resource "aws_s3_bucket_object" "s3_javacode_object" {
  bucket = aws_s3_bucket.javabucket.id
  key = var.aws_s3_bucket_object_key
  content_type = var.content_type
  acl = "private"
  source = local.java_zip_filename
  etag = filemd5(local.java_zip_filename)
}