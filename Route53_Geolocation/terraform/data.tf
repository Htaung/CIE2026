# Look up the existing Route 53 zone by its Zone ID
data "aws_route53_zone" "this" {
  zone_id = var.route53_zone_id
}