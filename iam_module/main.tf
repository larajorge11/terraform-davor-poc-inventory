resource "aws_iam_policy" "network" {
  name = var.aws_iam_policy_name
  policy = file("${path.module}/${var.POLICY_LAMBDA_NAME}")
}

resource "aws_iam_role" "lambda-vpc-role" {
  name = var.aws_iam_role_name
  assume_role_policy = file("${path.module}/${var.POLICY_LAMBDA_ASSUME_NAME}")

  depends_on = [var.aws_s3_bucket_javabucket]
}

resource "aws_iam_role_policy_attachment" "network" {
  role       = aws_iam_role.lambda-vpc-role.id
  policy_arn = aws_iam_policy.network.arn
}



