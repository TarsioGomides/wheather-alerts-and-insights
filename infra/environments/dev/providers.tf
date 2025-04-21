terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "sa-east-1"
}

module "backend" {
  source       = "../../global/backend"
  project_name = "wheather-alerts-and-insights"
}

module "iam" {
  source            = "../../global/iam"
  oidc_provider_arn = "arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"
  github_org        = var.github_org
  github_repo       = var.github_repo
  aws_account_id    = var.aws_account_id
}