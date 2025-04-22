# Elasticache Module

This Terraform module provisions an Amazon ElastiCache cluster (Redis) within private subnets for caching and high-speed data access.

## Resources Created

- **aws_elasticache_cluster** or **aws_elasticache_replication_group**: Redis cluster for caching.
- **Subnet Groups**: ElastiCache subnet groups for private subnet deployment.
- **Security Groups**: Control access to the ElastiCache cluster.

## Inputs

- `vpc_id`: VPC ID where ElastiCache is deployed.
- `private_subnet_ids`: List of private subnet IDs for ElastiCache.
- Other configuration variables for cluster size, node type, engine version, etc.

## Notes

- ElastiCache is deployed in private subnets for security.
- Ensure security groups allow access from application servers or other authorized resources.
- Use ElastiCache to improve application performance by caching frequently accessed data.
