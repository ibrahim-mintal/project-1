output "vpc_id" {
  value = aws_vpc.myvpc.id
}


output "private_subnet1_id" {
  value = aws_subnet.priv_sub1.id
}


output "private_subnet2_id" {
  value = aws_subnet.priv_sub2.id
}


output "public_subnet1_id" {
  value = aws_subnet.pub_sub1.id
}


output "public_subnet2_id" {
  value = aws_subnet.pub_sub2.id
}