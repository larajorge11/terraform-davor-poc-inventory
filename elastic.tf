resource "aws_elasticache_subnet_group" "default" {
  name = "subnet-elastic-19890806"
  subnet_ids = [ aws_subnet.main-private-1.id ]
}

resource "aws_elasticache_cluster" "davorredis" {
  cluster_id           = "davoredis19890806"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [aws_security_group.elastic_connection.id]

}