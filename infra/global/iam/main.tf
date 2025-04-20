# Role principal para Terraform
resource "aws_iam_role" "terraform_deploy" {
  name               = "TerraformDeployRole"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role.json
}

data "aws_iam_policy_document" "combined_policies" {
  # Permissões para S3/DynamoDB (backend)
  statement {
    actions   = ["s3:*", "dynamodb:*"]
    resources = ["*"]
  }

  # Permissões para Kinesis
  statement {
    actions   = ["kinesis:*"]
    resources = ["*"]
  }

  # Adicione outras permissões necessárias aqui
  # statement {
  #   actions   = ["logs:*"]
  #   resources = ["*"]
  # }
}

# Policies consolidadas
resource "aws_iam_policy" "terraform_permissions" {
  name   = "TerraformFullPermissions"
  policy = data.aws_iam_policy_document.combined_policies.json
}

# Anexa a policy consolidada à role
resource "aws_iam_role_policy_attachment" "main_attachment" {
  role       = aws_iam_role.terraform_deploy.name
  policy_arn = aws_iam_policy.terraform_permissions.arn
}