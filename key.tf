resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# Output Public IP and Private Key
output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Use this IP to connect to the Bastion Host"
}

output "bastion_private_key" {
  value       = tls_private_key.bastion_key.private_key_pem
  description = "Use this PEM to connect via SSH"
  sensitive   = true
}
