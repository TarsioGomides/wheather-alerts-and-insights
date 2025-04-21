terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-wheather-alerts-and-insights"
    key            = "dev/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-locks-wheather-alerts-and-insights"
    encrypt        = true
  }
}

provider "aws" {
  region = "sa-east-1"
}