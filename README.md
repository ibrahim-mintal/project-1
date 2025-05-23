# Full Terraform Project - AWS Infrastructure Deployment

---

## Overview

This Terraform project builds a **complete AWS infrastructure** including networking, compute, databases, caching, and serverless components. The project uses **Terraform Modules**, **Workspaces**, and **Provisioners**, and it supports multi-environment deployments (`dev` and `prod`).

---

## Architecture

### Networking
- **VPC** creation.
- **2 Public Subnets** (in different AZs).
- **2 Private Subnets** (in different AZs).
- **Internet Gateway**.
- **NAT Gateway**.
- **Public Route Table** with internet access.
- **Private Route Table** with NAT Gateway access.
- **Subnet associations** with respective route tables.

### Compute
- **Security Groups**:
  - Allow **SSH from anywhere** (0.0.0.0/0) for Bastion.
  - Allow **SSH and port 3000** only from **inside VPC** for Application Server.
- **EC2 Instances**:
  - Bastion Host (Public Subnet).
  - Application Server (Private Subnet).
- **Application Load Balancer (ALB)** with Auto Scaling Group (ASG) of EC2 instances running Apache HTTP server.

### Database
- **Amazon RDS (MySQL)**
  - Hosted in **Private Subnets**.
  - Highly secured with security groups.

- **Amazon Elasticache (Redis)**
  - Hosted in **Private Subnets**.
  - For caching and high-speed data access.

### Serverless
- **AWS Lambda Function**:
  - Sends email notifications via Amazon SES.
  - Triggered on **state file changes**.

- **Amazon SES**:
  - Email identity verified to send notifications.

---

## Folder Structure

```bash
modules/
├── network/          # VPC, Subnets, NAT Gateway, Route Tables
├── ALB_ASG/          # Application Load Balancer and Auto Scaling Group
├── bastion/          # Bastion Host Module
├── elasticache/      # Elasticache Redis Module
├── rds/              # RDS MySQL Module
main.tf               # Root Terraform configuration
variables.tf          # Root variables
outputs.tf            # Root outputs
provider.tf           # AWS Provider configuration
backend.tf            # Remote backend (state management)
workspaces/
├── dev.tfvars        # Variables for development environment
├── prod.tfvars       # Variables for production environment
lambda/
├── send_email.py     # Lambda function code to send SES email
README.md             # Project documentation (this file)
```

---

## Requirements

- Terraform >= 1.0.0
- AWS CLI configured locally
- AWS Provider >= 4.0.0

---

## Inputs (Root Module)

| Variable | Description | Type |
| :------ | :---------- | :-- |
| `region` | AWS Region (us-east-1, eu-central-1) | `string` |
| `vpc_cidr` | CIDR block for VPC | `string` |
| `pub_sub1_cidr` | CIDR block for Public Subnet 1 | `string` |
| `pub_sub2_cidr` | CIDR block for Public Subnet 2 | `string` |
| `priv_sub1_cidr` | CIDR block for Private Subnet 1 | `string` |
| `priv_sub2_cidr` | CIDR block for Private Subnet 2 | `string` |

---

## Outputs (Root Module)

| Output | Description |
| :----- | :---------- |
| `vpc_id` | VPC ID |
| `bastion_public_ip` | Public IP of Bastion Host |
| `application_private_ip` | Private IP of Application Server |
| `rds_endpoint` | RDS Endpoint |
| `elasticache_endpoint` | Elasticache Endpoint |

---

## Features

- **Multi-Region Support**: Deploy infrastructure in multiple AWS regions.
- **Multi-Environment Support**: Use `workspaces` for `dev` and `prod`.
- **Modules**: Clean separation of networking, database, caching, and compute components.
- **State File Notifications**: Lambda function triggers email alerts on state changes.
- **Secure Setup**: RDS and Elasticache are private, only accessible within VPC.
- **Provisioners**: Bastion public IP is automatically printed using `local-exec`.
- **Load Balancer and Auto Scaling**: ALB routes HTTP traffic to EC2 instances in ASG.

---

## Example Usage

```hcl
module "network" {
  source            = "./modules/network"
  region            = var.region
  vpc_cidr          = var.vpc_cidr
  pub_sub1_cidr     = var.pub_sub1_cidr
  pub_sub2_cidr     = var.pub_sub2_cidr
  priv_sub1_cidr    = var.priv_sub1_cidr
  priv_sub2_cidr    = var.priv_sub2_cidr
}

module "rds" {
  source              = "./modules/rds"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = [module.network.private_subnet1_id, module.network.private_subnet2_id]
}

module "elasticache" {
  source              = "./modules/elasticache"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = [module.network.private_subnet1_id, module.network.private_subnet2_id]
}

module "loadbalancer_asg" {
  source = "./modules/ALB_ASG"
  lb_security_groups        = [aws_security_group.sg-http.id]
  lb_subnets                = [module.network.public_subnet1_id, module.network.public_subnet2_id]
  lb_deletion_protection    = false
  vpc_id                   = module.network.vpc_id
  image_id                  = var.image_id
  instance_type             = var.aws_instance_type
  instance_security_groups  = [aws_security_group.sg-http.id]
  user_data                 = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd curl
    systemctl start httpd
    systemctl enable httpd
    # Additional user data script here
  EOF
  iam_instance_profile_name = aws_iam_instance_profile.ec2_profile.name
  asg_name                 = "asg-app"
  asg_max_size             = 3
  asg_min_size             = 1
  asg_desired_capacity     = 2
  asg_subnets              = [module.network.private_subnet1_id, module.network.private_subnet2_id]
  asg_health_check_type    = "ELB"
  asg_force_delete         = true
  asg_tag_name             = "ASG_Instance"
}

```

---

## Workspaces Setup

```bash
# Create workspaces
terraform workspace new dev
terraform workspace new prod

# Select workspace
terraform workspace select dev

# Apply with respective tfvars
terraform apply -var-file="workspaces/dev.tfvars"
```

---

## Notes

- Ensure **SES** email verification is complete before Lambda email sending.
- NAT Gateways incur cost; be mindful for testing environments.
- Always use separate workspaces for **prod** and **dev** to avoid conflicts.
- Use Terraform Cloud or S3 backend for storing remote states safely.

---

## Authors
- Infrastructure built by [Ibrahim Mintal]

---

## Acknowledgments

- [Terraform by HashiCorp](https://www.terraform.io/)
- [AWS Documentation](https://docs.aws.amazon.com/)

---

> _"Automate everything, secure everything, scale infinitely!"_ 🚀
