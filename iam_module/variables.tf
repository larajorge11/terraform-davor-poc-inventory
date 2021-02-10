variable "aws_iam_policy_name" {}

variable "aws_iam_role_name" {}

variable "POLICY_LAMBDA_ASSUME_NAME" {
    default = "lambda_assume_role_policy.json"
}

variable "POLICY_LAMBDA_NAME" {
    default = "lambda_policy.json"
}

variable "aws_s3_bucket_javabucket" {}