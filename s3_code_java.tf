
locals {
    java_zip_filename = "InventoryData-1.0.0-SNAPSHOT.zip"
}

resource "aws_s3_bucket" "javabucket" {
  bucket = "${var.ENV_NAME}-java-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_object" "s3_javacode_object" {
  bucket = aws_s3_bucket.javabucket.id
  key = "function/${local.java_zip_filename}"
  content_type = "application/zip"
  acl = "private"
  source = local.java_zip_filename
  etag = filemd5(local.java_zip_filename)
}