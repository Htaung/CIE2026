variable "domain_name" {
  type    = string
  default = "htaunghtaung.space"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "route53_zone_id" {
  type    = string
  default = "Z04816034RLHV5N4LSUK"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 203.0.113.5/32"
}