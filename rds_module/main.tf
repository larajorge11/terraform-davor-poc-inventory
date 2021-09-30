resource "aws_db_subnet_group" "postgresdb-subnet" {
    name = "postgresdb-subnet"
    description = "RDS subnet group"
    subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "postgresdb-parameters" {
    name = "postgresdb-parameters"
    family = "postgres13"
    description = "Postgres parameter group"

    parameter {
        name = "log_connections"
        value = "1"
    }
}

resource "aws_db_instance" "postgres" {
    allocated_storage = 10
    engine = "postgres"
    engine_version = "13.4"
    instance_class = "db.t3.small"
    identifier = "postgres"
    name = "postgres"
    username = "root"
    password = var.RDS_PASSWORD
    db_subnet_group_name = aws_db_subnet_group.postgresdb-subnet.name
    parameter_group_name = aws_db_parameter_group.postgresdb-parameters.name
    multi_az = false
    vpc_security_group_ids = var.vpc_security_group_ids
    storage_type = "gp2"
    backup_retention_period = 30
    availability_zone = var.availability_zone
    skip_final_snapshot = true
    tags = {
        Name = "postgres-instance"
    }
}