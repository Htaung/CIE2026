output "name_servers" {
  value = data.aws_route53_zone.this.name_servers
}