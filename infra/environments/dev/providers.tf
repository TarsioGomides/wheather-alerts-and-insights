terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = module.backend.s3_bucket_name
    key            = "dev/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = module.backend.dynamodb_table_name
    encrypt        = true
  }
}

provider "aws" {
  region = "sa-east-1"
  assume_role {
    role_arn = module.iam.terraform_role_arn
  }
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