module "sg" {
  source           = "./modules/region"
  name             = "sg"
  continent        = "AS"
  domain_name      = var.domain_name
  zone_id          = var.route53_zone_id
  instance_type    = var.instance_type
  vpc_cidr         = "10.10.0.0/16"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "us" {
  source           = "./modules/region"
  providers        = { aws = aws.us }
  name             = "us"
  continent        = "NA"
  domain_name      = var.domain_name
  zone_id          = var.route53_zone_id
  instance_type    = var.instance_type
  vpc_cidr         = "172.16.0.0/16"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "eu" {
  source           = "./modules/region"
  providers        = { aws = aws.eu }
  name             = "eu"
  continent        = "EU"
  domain_name      = var.domain_name
  zone_id          = var.route53_zone_id
  instance_type    = var.instance_type
  vpc_cidr         = "192.168.0.0/16"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

# Fallback for users from continents not listed above (AF, SA, OC...)
resource "aws_route53_record" "default" {
  zone_id        = var.route53_zone_id
  name           = var.domain_name
  type           = "A"
  set_identifier = "default"

  geolocation_routing_policy {
    country = "*"
  }

  alias {
    name                   = module.sg.alb_dns_name
    zone_id                = module.sg.alb_zone_id
    evaluate_target_health = true
  }
}