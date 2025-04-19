
# Create Security Group
resource "aws_security_group" "sg-http" {
  vpc_id = module.network.vpc_id # from outputs of network module
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add SSH ingress rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "HTTP-SG"
  }
}


# Create Security Group
resource "aws_security_group" "sg-bastion" {
  vpc_id = module.network.vpc_id # from outputs of network module


  # Add SSH ingress rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Bastion-SG"
  }
}