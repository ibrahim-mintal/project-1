
# Network Module for AWS Infrastructure

## Overview
This Terraform module sets up the essential networking components for an AWS infrastructure, including:
- A VPC (Virtual Private Cloud).
- Two public subnets and two private subnets, each in separate Availability Zones (AZs).
- A NAT Gateway for outbound internet access from private subnets.
- An Internet Gateway to provide internet access for resources in public subnets.
- Route tables and associations to manage traffic flow between subnets.

This module is ideal for setting up a basic VPC architecture suitable for hosting AWS services in a private network while allowing internet access where needed.

## Architecture
The network setup created by this module includes:
- 1 VPC (Virtual Private Cloud).
- 2 Availability Zones.
- 2 Public Subnets (one in each AZ).
- 2 Private Subnets (one in each AZ).
- 1 NAT Gateway for allowing private subnet instances to access the internet.
- 1 Internet Gateway for enabling internet access to the public subnets.

## Folder Structure
```bash
modules/
├── network/
│   ├── variables.tf      # Input variables for customization
│   ├── outputs.tf        # Outputs from the module
│   ├── vpc.tf            # VPC creation
│   ├── subnets.tf        # Subnet definitions (private and public)
│   ├── igw.tf            # Internet Gateway configuration
│   ├── nat-gw.tf         # NAT Gateway setup
│   └── route-tables.tf   # Route tables configuration
```

## Inputs

| Variable           | Description                                                    | Type   |
|--------------------|----------------------------------------------------------------|--------|
| `region`           | The AWS region to deploy the resources.                        | string |
| `vpc_cidr`         | The CIDR block for the VPC (e.g., 10.0.0.0/16).                | string |
| `pub_sub1_cidr`    | The CIDR block for the first public subnet (e.g., 10.0.1.0/24). | string |
| `pub_sub2_cidr`    | The CIDR block for the second public subnet (e.g., 10.0.2.0/24).| string |
| `priv_sub1_cidr`   | The CIDR block for the first private subnet (e.g., 10.0.3.0/24).| string |
| `priv_sub2_cidr`   | The CIDR block for the second private subnet (e.g., 10.0.4.0/24).| string |

## Outputs

| Output               | Description                           |
|-----------------------|---------------------------------------|
| `vpc_id`              | The ID of the created VPC             |
| `private_subnet1_id`  | The ID of the first private subnet    |
| `private_subnet2_id`  | The ID of the second private subnet   |
| `public_subnet1_id`   | The ID of the first public subnet     |
| `public_subnet2_id`   | The ID of the second public subnet    |

## Example Usage

```hcl
module "network" {
  source = "./modules/network"

  region                 = "us-west-2"
  vpc_cidr               = "10.0.0.0/16"
  pub_sub1_cidr          = "10.0.1.0/24"
  pub_sub2_cidr          = "10.0.2.0/24"
  priv_sub1_cidr         = "10.0.3.0/24"
  priv_sub2_cidr         = "10.0.4.0/24"
}
```

## Component Breakdown

### VPC (Virtual Private Cloud)
- **File**: `vpc.tf`
- Defines the VPC with the CIDR block provided in the `vpc_cidr` variable.

### Subnets (Public and Private)
- **File**: `subnets.tf`
- Creates two public subnets and two private subnets across two Availability Zones (AZs).

### Internet Gateway (IGW)
- **File**: `igw.tf`
- Creates and attaches an Internet Gateway to the VPC, enabling internet access for public subnets.

### NAT Gateway (NAT-GW)
- **File**: `nat-gw.tf`
- Creates a NAT Gateway in one of the public subnets, allowing instances in private subnets to access the internet.

### Route Tables
- **File**: `route-tables.tf`
- Defines and associates route tables:
  - Public subnets are routed via the Internet Gateway.
  - Private subnets are routed via the NAT Gateway for outbound internet traffic.

## Notes
- **Security Groups & IAM**: Remember to configure the appropriate security groups and IAM roles for better security.
- **NAT Gateway Costs**: Using a NAT Gateway incurs charges. For smaller deployments, consider using a NAT Instance.
- **High Availability**: Subnets and resources are distributed across two Availability Zones for better availability.

## Requirements
- Terraform version >= 1.0.0
- AWS Provider version >= 3.0.0

## Conclusion
This module sets up a highly configurable and secure networking foundation for your AWS infrastructure, complete with private and public subnets, a NAT Gateway, and an Internet Gateway.

It’s a great starting point for launching applications in a secure environment that needs controlled internet access.

---

Feel free to clone or fork this repository to customize and extend the module according to your needs!
