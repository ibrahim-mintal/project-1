
module "network" {
  source = "./modules/network"
  region = var.region

  vpc_cidr = var.vpc_cidr

  priv_sub1_cidr = var.Priv_Sub_1_cidr

  priv_sub2_cidr = var.Priv_Sub_2_cidr

  pub_sub1_cidr = var.Pub_Sub_1_cidr

  pub_sub2_cidr = var.Pub_Sub_2_cidr


}


module "rds" {
  source = "./modules/rds"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = [module.network.private_subnet2_id, module.network.private_subnet1_id]

  db_name     = var.rds_name
  db_username = var.rds_username
  db_password = var.rds_password
}



module "elasticache" {
  source = "./modules/elasticache"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = [module.network.private_subnet2_id]

  cluster_id = "my-redis-cluster"
}

