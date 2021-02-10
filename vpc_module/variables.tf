variable "vpc_id" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
  default = "10.0.4.0/24"
}

variable "availability_zone" {
  default = "eu-west-2a"
}

variable "service_name_vpc_endpoint" {
  default = "com.amazonaws.eu-west-2.s3"
}