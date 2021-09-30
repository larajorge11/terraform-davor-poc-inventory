 # Internet VPC
resource "aws_vpc" "davorvpc" {
  
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false
  
  tags = {
    Name = "davorvpc"
  }

}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id = aws_vpc.davorvpc.id
  cidr_block = var.subnet_public_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id = aws_vpc.davorvpc.id
  cidr_block = var.subnet_private_cidr
  map_public_ip_on_launch = false
  availability_zone = var.availability_zone

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id = aws_vpc.davorvpc.id
  cidr_block = var.subnet_private_cidr_2
  map_public_ip_on_launch = false
  availability_zone = var.availability_zone_2

  tags = {
    Name = "main-private-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.davorvpc.id
  
  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.davorvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.davorvpc.id
  tags = {
    Name = "main-private-1"
  }
}

resource "aws_route_table" "main-private-2" {
  vpc_id = aws_vpc.davorvpc.id
  tags = {
    Name = "main-private-2"
  }
}

resource "aws_route_table_association" "subnetassociation" {
  subnet_id = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "subnetassociation-2" {
  subnet_id = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private-2.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.davorvpc.id
  service_name      = var.service_name_vpc_endpoint
  vpc_endpoint_type = "Gateway"

  route_table_ids = [ aws_route_table.main-private.id ]
}