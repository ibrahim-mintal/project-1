# RDS Module

This Terraform module provisions an Amazon RDS MySQL instance inside private subnets for secure database deployments.

## Resources Created

- **aws_db_instance**: RDS MySQL instance with specified configurations.
- **Subnet Groups**: RDS subnet groups for private subnet deployment.
- **Security Groups**: Control access to the RDS instance.

## Inputs

- `vpc_id`: VPC ID where RDS is deployed.
- `private_subnet_ids`: List of private subnet IDs for RDS.
- `db_name`: Name of the database.
- `db_username`: Master username.
- `db_password`: Master password.
- Other configuration variables for instance class, storage, backup, etc.

## Usage

To use this module, include it in your root Terraform configuration as follows:

```hcl
module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.network.vpc_id
  private_subnet_ids  = [module.network.private_subnet1_id, module.network.private_subnet2_id]
  db_name            = var.rds_name
  db_username        = var.rds_username
  db_password        = var.rds_password
}
```

## Notes

- The RDS instance is deployed in private subnets for security.
- Ensure security groups allow access only from authorized resources.
- Backup and maintenance windows should be configured as per requirements.
