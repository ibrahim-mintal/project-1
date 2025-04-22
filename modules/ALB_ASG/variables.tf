variable "lb_security_groups" {
  description = "Security groups for the load balancer"
  type        = list(string)
}

variable "lb_subnets" {
  description = "Subnets for the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the launch template"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the launch template"
  type        = string
}

variable "instance_security_groups" {
  description = "Security groups for the instances"
  type        = list(string)
}

variable "asg_subnets" {
  description = "Subnets for the auto scaling group"
  type        = list(string)
}

variable "lb_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}


variable "iam_instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "asg_name" {
  description = "Name of the auto scaling group"
  type        = string
}

variable "user_data" {
  description = "User data script for the launch template"
  type        = string
}
