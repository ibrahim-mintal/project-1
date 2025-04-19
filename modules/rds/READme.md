# RDS Module for AWS Infrastructure

## Overview
This Terraform module provisions an Amazon RDS (MySQL) instance inside private subnets. It is designed for secure database deployments that are not directly accessible from the public internet.

## Architecture
The setup includes:
- 1 RDS instance (MySQL)
- Deployment inside private subnets
- Security group allowing only necessary access

## Folder Structure
```bash
modules/
└── rds/
    ├── variables.tf      # Input variables for customization
    ├── outputs.tf        # Outputs from the module
    └── main.tf           # Resource definitions (RDS instance)
```

## Inputs

| Variable            | Description                                 | Type          |
|---------------------|---------------------------------------------|---------------|
| db_name             | Name of the initial database               | string        |
| db_username         | Master username for the database           | string        |
| db_password         | Master password for the database           | string        |
| db_instance_class   | Instance type for the RDS (e.g., db.t3.micro) | string      |
| private_subnet_ids  | List of private subnet IDs                 | list(string)  |
| vpc_id              | ID of the VPC where the RDS will be deployed | string      |

## Outputs

| Output               | Description                     |
|----------------------|---------------------------------|
| rds_endpoint         | The endpoint address of the RDS |
| rds_security_group_id| Security Group ID attached to RDS |

## Example Usage
```hcl
module "rds" {
  source             = "./modules/rds"
  db_name            = "mydatabase"
  db_username        = "admin"
  db_password        = "yourpassword"
  db_instance_class  = "db.t3.micro"
  private_subnet_ids = [
    module.network.private_subnet1_id,
    module.network.private_subnet2_id
  ]
  vpc_id             = module.network.vpc_id
}
```

## Notes
- **Security Groups** should be managed carefully to restrict access to the database.
- **Backup settings**, **multi-AZ**, and **encryption** options can be added for production deployments.
- **T3.micro** instances are eligible for AWS Free Tier for new accounts (Check [AWS Free Tier offerings](https://aws.amazon.com/free/)).

## Requirements
- Terraform version >= 1.0.0
- AWS Provider version >= 3.0.0

## Conclusion
This module provides a simple and secure way to deploy an RDS MySQL database inside your VPC, leveraging private subnets to ensure isolation and security.

