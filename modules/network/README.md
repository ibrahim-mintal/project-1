# Network Module

This Terraform module provisions the networking components required for the AWS infrastructure.

## Resources Created

- **VPC**: Virtual Private Cloud.
- **Subnets**: Public and private subnets across multiple availability zones.
- **Internet Gateway**: For internet access to public subnets.
- **NAT Gateway**: For outbound internet access from private subnets.
- **Route Tables**: Public and private route tables with appropriate routes.
- **Subnet Associations**: Associates subnets with route tables.

## Inputs

- `region`: AWS region.
- `vpc_cidr`: CIDR block for the VPC.
- `pub_sub1_cidr`, `pub_sub2_cidr`: CIDR blocks for public subnets.
- `priv_sub1_cidr`, `priv_sub2_cidr`: CIDR blocks for private subnets.

## Usage

To use this module, include it in your root Terraform configuration as follows:

```hcl
module "network" {
  source        = "./modules/network"
  region        = var.region
  vpc_cidr      = var.vpc_cidr
  pub_sub1_cidr = var.pub_sub1_cidr
  pub_sub2_cidr = var.pub_sub2_cidr
  priv_sub1_cidr = var.priv_sub1_cidr
  priv_sub2_cidr = var.priv_sub2_cidr
}
```

This will create a VPC with two public and two private subnets across different availability zones, along with the necessary internet gateway, NAT gateway, and route tables.

## Notes

- Ensures high availability by deploying subnets in multiple availability zones.
- Provides secure networking foundation for other modules.
- NAT Gateway allows private subnets to access the internet securely.
