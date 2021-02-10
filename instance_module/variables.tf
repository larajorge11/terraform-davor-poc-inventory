variable "AWS_REGION" {
    type = string
    default = "eu-west-2"
}

variable "AMIS" {
    type = map(string)
    default = {
        eu-west-2 = "ami-098828924dc89ea4a"
    }
}

variable "PATH_PUBLIC_KEY" {
  default = ".ssh/davorkey.pub"
}

variable "PATH_PRIVATE_KEY" {
  default = ".ssh/davorkey"
}

variable "aws_key_pair" {
  default = "davorkey"
}

variable "subnet_id" {}

variable "vpc_security_group_ids" {}

variable "instance_type" {
  default = "t2.micro"
}