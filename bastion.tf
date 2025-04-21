module "bastion" {
  source = "./modules/bastion"

  image_id          = var.image_id
  instance_type     = var.aws_instance_type
  subnet_id         = module.network.public_subnet1_id
  availability_zone = "${var.region}a"
  security_group_ids = [aws_security_group.sg-bastion.id]
  key_name          = aws_key_pair.bastion_key.key_name
}
