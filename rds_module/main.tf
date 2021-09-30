resource "aws_db_subnet_group" "mariadb-subnet" {
    name = "mariadb-subnet"
    description = "RDS subnet group"
    subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "mariadb-parameters" {
    name = "mariadb-parameters"
    family = "mariadb10.5"
    description = "MariaDB parameter group"

    parameter {
        name = "max_allowed_packet"
        value = "16777216"
    }
}

resource "aws_db_instance" "mariadb" {
    allocated_storage = 10
    engine = "mariadb"
    engine_version = "10.5.12"
    instance_class = "db.t3.small"
    identifier = "mariadb"
    name = "mariadb"
    username = "root"
    password = var.RDS_PASSWORD
    db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
    parameter_group_name = aws_db_parameter_group.mariadb-parameters.name
    multi_az = false
    vpc_security_group_ids = var.vpc_security_group_ids
    storage_type = "gp2"
    backup_retention_period = 30
    availability_zone = var.vpc_security_group_ids
    skip_final_snapshot = true
    tags = {
        Name = "mariadb-instance"
    }
}