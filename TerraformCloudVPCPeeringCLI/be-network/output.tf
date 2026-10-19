output "backend_vpc_id" {
  value = aws_vpc.hc_backend_vpc.id
}


output "backend_pub_subnet1_id" {
  value = aws_subnet.backend_pub_subnet1.id
}
output "backend_private_subnet1_id" {
  value = aws_subnet.backend_private_subnet1.id
}
output "backend_private_subnet2_id" {
  value = aws_subnet.backend_private_subnet2.id
}
output "backend_private_subnet3_id" {
  value = aws_subnet.backend_private_subnet3.id
}