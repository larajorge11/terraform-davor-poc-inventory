resource "aws_instance" "davorinstance" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.vpc_security_group_ids]
    key_name = aws_key_pair.davorkey.key_name

    tags = {
      Name = "Development"
    }
}

resource "aws_key_pair" "davorkey" {
  key_name = var.aws_key_pair
  public_key = file("${path.module}/${var.PATH_PUBLIC_KEY}")
}