resource "aws_elasticache_subnet_group" "default" {
  name = "subnet-elastic-19890806"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "davorredis" {
  cluster_id           = var.cluster_id
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = var.parameter_group_name
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = var.security_group_ids

}