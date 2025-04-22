output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.myelb.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.target_Group.arn
}

output "autoscaling_group_name" {
  description = "Name of the auto scaling group"
  value       = aws_autoscaling_group.app.name
}
