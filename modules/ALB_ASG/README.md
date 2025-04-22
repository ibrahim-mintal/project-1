# ALB_ASG Module

This Terraform module provisions an Application Load Balancer (ALB) along with an Auto Scaling Group (ASG) of EC2 instances.

## Resources Created

- **aws_lb**: Application Load Balancer configured with security groups and public subnets.
- **aws_lb_target_group**: Target group for the ALB on port 80 with HTTP health checks.
- **aws_lb_listener**: Listener on port 80 forwarding traffic to the target group.
- **aws_launch_template**: Launch template for EC2 instances with user data to install and start Apache HTTP server.
- **aws_autoscaling_group**: Auto Scaling Group with instances launched in private subnets, attached to the ALB target group.

## Inputs

- `lb_security_groups`: Security groups for the load balancer.
- `lb_subnets`: Subnets for the load balancer (usually public subnets).
- `vpc_id`: VPC ID for the target group.
- `image_id`: AMI ID for EC2 instances.
- `instance_type`: EC2 instance type.
- `instance_security_groups`: Security groups for EC2 instances.
- `asg_subnets`: Subnets for the ASG (usually private subnets).
- `asg_health_check_type`: Health check type for ASG (should be "ELB" for ALB integration).
- Other variables for ASG sizing, IAM profile, user data, and deletion protection.

## Notes

- Ensure the ASG health check type is set to "ELB" to allow proper health monitoring via the ALB.
- Security groups must allow inbound HTTP traffic from the ALB to the instances.
- User data installs and starts Apache HTTP server to serve HTTP requests.
