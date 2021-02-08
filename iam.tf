resource "aws_iam_policy" "network" {
  name = "${var.ENV_NAME}_lambda_policy"
  policy = file(var.POLICY_LAMBDA_NAME)
}

resource "aws_iam_role" "lambda-vpc-role" {
  name = "${var.ENV_NAME}-lambda"
  assume_role_policy = file(var.POLICY_LAMBDA_ASSUME_NAME)

  depends_on = [ aws_s3_bucket.javabucket ]
}

#resource "aws_iam_policy_attachment" "network" {
#  name       = "lambdaelastic-network"
#  roles      = [aws_iam_role.lambda-vpc-role.name]
#  policy_arn = aws_iam_policy.network.arn
#}
resource "aws_iam_role_policy_attachment" "network" {
  role       = aws_iam_role.lambda-vpc-role.id
  policy_arn = aws_iam_policy.network.arn
}



