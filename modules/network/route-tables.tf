# Create Route Table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_RT"
  }
}
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "private_RT"
  }
}


# Update Private Route Table to Route Traffic Through NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}


# Associate Subnets with Route Tables
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.priv_sub1.id
  route_table_id = aws_route_table.private_RT.id
}
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.priv_sub2.id
  route_table_id = aws_route_table.private_RT.id
}
resource "aws_route_table_association" "subnet3_association" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.public_RT.id
}
resource "aws_route_table_association" "subnet4_association" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.public_RT.id
}