terraform {
  backend "s3" {
    bucket = "mikesarfaty-terraform-states"
    key    = "production.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}
