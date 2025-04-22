
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
  source = "./modules/loadbalancer_asg"

  lb_name                   = "ALB-ibrahim"
  lb_internal               = false
  lb_security_groups        = [aws_security_group.sg-http.id]
  lb_subnets                = [module.network.public_subnet1_id, module.network.public_subnet2_id]
  lb_deletion_protection    = false
  lb_tags                   = { Name = "Ibrahim App" }

  target_group_name         = "TG-ibrahim"
  target_group_port         = 80
  target_group_protocol     = "HTTP"
  vpc_id                   = module.network.vpc_id
  health_check_protocol     = "HTTP"
  health_check_path         = "/"
  target_group_tags         = { Name = "TG-ibrahim" }

  listener_port            = 80
  listener_protocol        = "HTTP"

  launch_template_name_prefix = "app-launch-template-"
  image_id                  = var.image_id
  instance_type             = var.aws_instance_type
  key_name                  = "bastion-key"
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
