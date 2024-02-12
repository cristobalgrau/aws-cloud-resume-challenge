variable "aws-region" {
  description = "AWS Region to deploy the Infrastructure"
  type        = string
}

variable "database-name" {
  description = "Name for the database used for views counter"
  type        = string
}

variable "lambda-name" {
  description = "Name for the Lambda Function used to read and increase counter in DynamoDB"
  type        = string
}

variable "api-name" {
  description = "Name for the API Gateway"
  type        = string
}