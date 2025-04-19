resource "aws_instance" "bastion" {
  ami                         = var.image_id # Amazon Linux 2023 AMI in us-east-1
  instance_type               = var.aws_instance_type
  subnet_id                   = module.network.public_subnet1_id # from outputs of network module
  availability_zone           = "${var.region}a"
  vpc_security_group_ids      = [aws_security_group.sg-bastion.id]
  key_name                    = aws_key_pair.bastion_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}
