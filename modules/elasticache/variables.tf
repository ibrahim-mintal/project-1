variable "vpc_id" {
  description = "VPC ID where Elasticache will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for Elasticache"
  type        = list(string)
}

variable "cluster_id" {
  description = "Cluster ID for Redis"
  type        = string
}
