resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-eip"
  }
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_sub2.id
  tags = {
    Name = "nat-gateway"
  }
}