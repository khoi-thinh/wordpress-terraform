provider "aws" {
    region = "ap-southeast-1"
}

terraform {
  required_version = ">=1.0.0,<=1.6.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
  }
}

