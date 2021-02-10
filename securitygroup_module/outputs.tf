output "ssh_connection_id" {
    value = aws_security_group.ssh_connection.id
}

output "security_group_ids" {
    value = aws_security_group.elastic_connection.id
}