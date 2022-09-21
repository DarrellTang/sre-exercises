data "aws_caller_identity" "current" {}

resource "aws_iam_role" "role" {
  name = format("%v-role", var.svc_user_name)

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = data.aws_caller_identity.current.account_id
        }
      },
    ]
  })
}

resource "aws_iam_group" "group" {
  name = format("%v-group", var.svc_user_name)
  path = "/users/"
}

resource "aws_iam_user" "user" {
  name = var.svc_user_name
  path = "/system/"
}

resource "aws_iam_group_membership" "team_membership" {
  name = format("%v-membership", var.svc_user_name)

  users = [
    aws_iam_user.user.name,
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group_policy" "team_policy" {
  name  = format("%v-group-policy", var.svc_user_name)
  group = aws_iam_group.group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.role.arn
      },
    ]
  })
}
