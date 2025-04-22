
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

module "bastion" {
  source = "./modules/bastion"

  image_id          = var.image_id
  instance_type     = var.aws_instance_type
  subnet_id         = module.network.public_subnet1_id
  availability_zone = "${var.region}a"
  security_group_ids = [aws_security_group.sg-bastion.id]
  key_name          = aws_key_pair.bastion_key.key_name
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
    yum install -y python3
    echo "Hello from ASG instance: $(hostname -f)" > /home/ec2-user/index.html
    cd /home/ec2-user
    nohup python3 -m http.server 80 &
  EOF





  iam_instance_profile_name = aws_iam_instance_profile.ec2_profile.name

  asg_name                 = "asg-app"
  asg_max_size             = 3
  asg_min_size             = 1
  asg_desired_capacity     = 2
  asg_subnets              = [module.network.private_subnet1_id, module.network.private_subnet2_id]
  asg_health_check_type    = "EC2"
  asg_force_delete         = true
  asg_tag_name             = "ASG_Instance"
}
