output "main-public-1" {
    value = aws_subnet.main-public-1.id
}

output "main-public-2" {
    value = aws_subnet.main-public-2.id
}

output "subnet_ids" {
    value = aws_subnet.main-private-1.id
}

output "subnet_ids_2" {
    value = aws_subnet.main-private-2.id
}

output "subnet_availability_zone" {
    value = aws_subnet.main-private-1.availability_zone
}

output "subnet_availability_zone_2" {
    value = aws_subnet.main-private-2.availability_zone
}

output "vpc_id" {
    value = aws_vpc.davorvpc.id
}

output "vpc_cidr" {
    value = aws_vpc.davorvpc.cidr_block
}