variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}


#############################################################
# Frontend VPC Variables
#############################################################

variable "frontend_prefix" {
  description = "The prefix for the frontend resources."
  default     = "hc-frontend"
}

variable "frontend_environment" {
  description = "The environment for the frontend resources."
  default     = "dev"
}

variable "frontend_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "HC FrontEnd VPC"
}

variable "frontend_pub_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "frontend_private_subnet_cidr_blocks" {
  default = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
}

variable "fe_instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t3.micro"
}

#############################################################
# Backend VPC Variables
#############################################################
variable "backend_prefix" {
  description = "The prefix for the frontend resources."
  default     = "hc-backend"
}

variable "backend_environment" {
  description = "The environment for the frontend resources."
  default     = "dev"
}

variable "backend_vpc_cidr_block" {
  type        = string
  default     = "192.168.0.0/16"
  description = "HC Backend VPC"
}


variable "backend_pub_subnet_cidr_blocks" {
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "backend_private_subnet_cidr_blocks" {
  default = ["192.168.253.0/24", "192.168.254.0/24", "192.168.255.0/24"]
}

variable "be_instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t3.micro"
}

#############################################################
# App Variables
#############################################################

variable "fe_placeholder" {
  default     = "placedog.net"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "be_placeholder" {
  default     = "placebear.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "placeholder_id" {
  default     = "2"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}

