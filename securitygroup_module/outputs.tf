output "security_group_ids" {
    value = aws_security_group.rds_connection.id
}