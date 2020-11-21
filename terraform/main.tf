resource "aws_lambda_function" "this" {
  function_name    = var.name
  filename         = "../this.zip"
  role             = aws_iam_role.this.arn
  handler          = "main.main"
  source_code_hash = filebase64sha256("../this.zip")
  runtime          = "python3.8"
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
