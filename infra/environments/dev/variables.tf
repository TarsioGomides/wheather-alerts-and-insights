variable "aws_account_id" {
  type        = string
  description = "ID da conta AWS"
}

variable "github_org" {
  type        = string
  description = "Nome da organização no GitHub"
  default     = "sua-org"  # Substitua pelo seu org
}

variable "github_repo" {
  type        = string
  description = "Nome do repositório no GitHub"
  default     = "seu-repo" # Substitua pelo seu repo
}