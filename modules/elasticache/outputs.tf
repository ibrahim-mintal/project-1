output "redis_endpoint" {
  description = "Redis endpoint address"
  value       = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "elasticache_security_group_id" {
  description = "Elasticache Security Group ID"
  value       = aws_security_group.this.id
}
