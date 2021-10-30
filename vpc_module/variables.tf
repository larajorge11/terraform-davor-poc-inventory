variable "vpc_id" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_public_cidr_2" {
  default = "10.0.2.0/24"
}

variable "subnet_private_cidr" {
  default = "10.0.4.0/24"
}

variable "subnet_private_cidr_2" {
  default = "10.0.5.0/24"
}

variable "availability_zone" {
  default = "eu-west-2a"
}

variable "availability_zone_2" {
  default = "eu-west-2b"
}

variable "service_name_vpc_endpoint" {
  default = "com.amazonaws.eu-west-2.s3"
}