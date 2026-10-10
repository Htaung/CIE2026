output "alb_dns_name"    { value = aws_lb.this.dns_name }
output "alb_zone_id"     { value = aws_lb.this.zone_id }
output "jump_public_ip"  { value = aws_instance.jump.public_ip }
output "app_private_ips" { value = aws_instance.app[*].private_ip }