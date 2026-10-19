output "frontend_vpc_id" {
  value = aws_vpc.hc_frontend_vpc.id
}


output "frontend_pub_subnet1_id" {
  value = aws_subnet.frontend_pub_subnet1.id
}
output "frontend_private_subnet1_id" {
  value = aws_subnet.frontend_private_subnet1.id
}
output "frontend_private_subnet2_id" {
  value = aws_subnet.frontend_private_subnet2.id
}
output "frontend_private_subnet3_id" {
  value = aws_subnet.frontend_private_subnet3.id
}

output "frontend_private_rtb02_id" {
  value = aws_route_table.frontend_private_rtb02.id
}
output "frontend_private_rtb03_id" {
  value = aws_route_table.frontend_private_rtb03.id
}