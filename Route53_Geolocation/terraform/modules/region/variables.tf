variable "name"             { type = string }
variable "continent"        { type = string }
variable "domain_name"      { type = string }
variable "zone_id"          { type = string }
variable "instance_type"    { type = string }
variable "vpc_cidr"         { type = string }
variable "allowed_ssh_cidr" { type = string }  # your public IP, e.g. "203.0.113.5/32"