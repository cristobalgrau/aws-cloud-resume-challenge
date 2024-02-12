# ===== LAMBDA FUNCTION SECTION || AWS Lambda =====

# ----> Creation of Lambda Function
resource "aws_lambda_function" "counter_lambda" {
  filename      = "${path.module}/lambda/lambda_function_payload.zip"
  function_name = var.lambda-name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

  tags = {
    Project = "Cloud-Resume"
  }
}

# ----> Creation of URL to invoque lambda
# resource "aws_lambda_function_url" "lamdba_url" {
#   function_name      = aws_lambda_function.counter_lambda.function_name
#   authorization_type = "NONE"

#   cors {
#     allow_credentials = false
#     allow_origins     = ["*"]
#   }
# }

# ----> Creation of role for lambda Function
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# ----> Creation of IAM Policy for DynamoDB manipulation
resource "aws_iam_policy" "policy" {
  name        = "dynamodb-policy"
  description = "A policy to manipulate DynamoDB"
  policy      = data.aws_iam_policy_document.dynamodb_permissions.json
}

# ----> Attaching the DynamoDB policy created to the Role
resource "aws_iam_role_policy_attachment" "attach-dynamodb-policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy.arn
}

# ----> Allow the API Gateway to call the Lambda Function
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.counter_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws-region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.views.path}"
}