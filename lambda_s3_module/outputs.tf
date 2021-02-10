output "aws_lambda_function_arn" {
    value = aws_lambda_function.lambda_refresh.arn
}

output "aws_lambda_permission_allow_bucket" {
    value = aws_lambda_permission.allow_bucket
}