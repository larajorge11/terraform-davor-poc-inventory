resource "aws_instance" "davorinstance" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.vpc_security_group_ids]
    key_name = aws_key_pair.davorkey.key_name

    provisioner "file" {
      source = "${path.module}/scripts/elasticache.sh"
      destination = "/tmp/elasticache.sh"
  }

  provisioner "remote-exec" {
      inline = [
          "chmod +x /tmp/elasticache.sh",
          "sudo sed -i -e 's/\r$//' /tmp/elasticache.sh",
          "sudo /tmp/elasticache.sh"
      ]
  }

  connection {
    type = "ssh"
    host = coalesce(self.public_ip, self.private_ip)
    user = var.instance_username
    private_key = file("${path.module}/${var.PATH_PRIVATE_KEY}")
  }

    tags = {
      Name = "Development"
    }
}

resource "aws_key_pair" "davorkey" {
  key_name = var.aws_key_pair
  public_key = file("${path.module}/${var.PATH_PUBLIC_KEY}")
}