terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    tls   = { source = "hashicorp/tls", version = "~> 4.0" }
    local = { source = "hashicorp/local", version = "~> 2.0" }
  }
}



# default = sg (also used for Route 53, which is global)
provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "us"
  region = "us-west-1"
}

provider "aws" {
  alias  = "eu"
  region = "eu-west-2"
}