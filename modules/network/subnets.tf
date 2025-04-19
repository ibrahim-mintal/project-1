resource "aws_subnet" "priv_sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.priv_sub1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "Private Subnet 1"
  }
}


resource "aws_subnet" "priv_sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.priv_sub2_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "Private Subnet 2"
  }
}


resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pub_sub1_cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}


resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pub_sub2_cidr
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}