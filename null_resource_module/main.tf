resource "null_resource" "lambda_function" {
    provisioner "local-exec" {
        command = "pwd"
    }
}