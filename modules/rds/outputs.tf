output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.this.endpoint
}

output "rds_security_group_id" {
  description = "Security Group ID used by RDS"
  value       = aws_security_group.this.id
}
