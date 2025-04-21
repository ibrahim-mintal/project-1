variable "image_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the bastion host will be deployed"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the bastion host"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the bastion host"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH access to the bastion host"
  type        = string
}
