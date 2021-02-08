resource "aws_security_group" "elastic_connection" {
  name        =  var.SG_NAME
  vpc_id      =  aws_vpc.davorvpc.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.davorvpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Name = "allow_elastic"
  }
}

resource "aws_security_group" "ssh_connection" {
  name        =  "sgelastic_instance"
  vpc_id      =  aws_vpc.davorvpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Name = "allow_ssh"
  }
}
