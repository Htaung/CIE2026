terraform {
  required_version = ">= 1.16"

  cloud {
    
    organization = "aungcloud-tfc"

    workspaces {
      name = "fe-security-ws"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.69.1"
    }

    tfe = { source = "hashicorp/tfe" }
  }

  
}