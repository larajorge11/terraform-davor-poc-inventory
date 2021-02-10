output "aws_s3_bucket_id" {
    value = aws_s3_bucket.javabucket.id
}

output "aws_s3_bucket_object_key" {
    value = aws_s3_bucket_object.s3_javacode_object.key
}

output "aws_s3_bucket_javabucket" {
    value = aws_s3_bucket.javabucket
}
