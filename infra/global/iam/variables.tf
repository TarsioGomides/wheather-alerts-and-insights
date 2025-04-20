# infra/global/iam/variables.tf
variable "oidc_provider_arn" {
  description = "ARN do OIDC Provider da AWS para GitHub Actions"
  type        = string
}

variable "github_org" {
  description = "Nome da organização no GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório no GitHub"
  type        = string
}

variable "aws_account_id" {
  description = "ID da conta AWS"
  type        = string
}