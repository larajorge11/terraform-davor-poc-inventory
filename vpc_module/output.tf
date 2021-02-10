output "main-public-1" {
    value = aws_subnet.main-public-1.id
}

output "subnet_ids" {
    value = aws_subnet.main-private-1.id
}

output "vpc_id" {
    value = aws_vpc.davorvpc.id
}

output "vpc_cidr" {
    value = aws_vpc.davorvpc.cidr_block
}