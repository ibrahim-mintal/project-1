resource "aws_instance" "bastion" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  availability_zone           = var.availability_zone
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}
