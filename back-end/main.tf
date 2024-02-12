terraform {
  backend "s3" {
    bucket = "terraform-state-grau"
    key    = "CloudResume/aws_infra"
    region = "us-east-1"
  }
  required_version = ">= 1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.1"
    }
  }
}

provider "aws" {
  region = var.aws-region
}


# ===== OUTPUT SECTION =====

output "API-URL" {
  value = "Invoke URL needed for index.js: ${aws_api_gateway_stage.resume.invoke_url}"
}


# ===== DATA SOURCE SECTION =====

# ----> Allow querys on AWS Identity data
data "aws_caller_identity" "current" {}

# ----> Creation of a zip file with Lambda function to upload
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda_function_payload.zip"
}

# ----> Define an IAM Policy Document to allow AssumeRole action
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# ----> Policy to provide some permission to DynamoDB
data "aws_iam_policy_document" "dynamodb_permissions" {
  statement {
    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem"
    ]
    resources = ["arn:aws:dynamodb:${var.aws-region}:${data.aws_caller_identity.current.account_id}:table/${var.database-name}"]
  }
}