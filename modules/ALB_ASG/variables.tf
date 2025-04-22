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

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "lb_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "lb_tags" {
  description = "Tags for the load balancer"
  type        = map(string)
  default     = {}
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
}

variable "target_group_tags" {
  description = "Tags for the target group"
  type        = map(string)
  default     = {}
}

variable "listener_port" {
  description = "Listener port"
  type        = number
}

variable "listener_protocol" {
  description = "Listener protocol"
  type        = string
}

variable "launch_template_name_prefix" {
  description = "Name prefix for the launch template"
  type        = string
}

variable "key_name" {
  description = "Key name for the instances"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "asg_name" {
  description = "Name of the auto scaling group"
  type        = string
}

variable "asg_max_size" {
  description = "Maximum size of the auto scaling group"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum size of the auto scaling group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the auto scaling group"
  type        = number
}

variable "asg_health_check_type" {
  description = "Health check type for the auto scaling group"
  type        = string
}

variable "asg_force_delete" {
  description = "Force delete the auto scaling group"
  type        = bool
}

variable "asg_tag_name" {
  description = "Tag name for the auto scaling group instances"
  type        = string
}

variable "user_data" {
  description = "User data script for the launch template"
  type        = string
}
