# Bastion Module

This Terraform module provisions a Bastion Host EC2 instance within a public subnet to provide secure SSH access to resources in private subnets.

## Resources Created

- **aws_instance**: EC2 instance configured as a bastion host.
- **Security Groups**: Allow SSH access from specified IP ranges.
- **Key Pair**: Uses an existing key pair for SSH access.

## Inputs

- `image_id`: AMI ID for the bastion host.
- `instance_type`: EC2 instance type.
- `subnet_id`: Subnet ID where the bastion host is deployed (usually a public subnet).
- `security_group_ids`: Security groups attached to the bastion host.
- `key_name`: SSH key pair name.

## Notes

- The bastion host allows secure access to private instances in the VPC.
- Ensure security groups restrict SSH access appropriately for security.
- Use the bastion host as a jump server for administrative tasks.
