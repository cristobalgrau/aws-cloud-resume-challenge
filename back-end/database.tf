# ===== DATABASE SECTION || DynamoDB =====

# ----> DynamoDB table for visits counter
resource "aws_dynamodb_table" "views-counter" {
  name         = var.database-name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "counter"

  attribute {
    name = "counter"
    type = "S"
  }

  tags = {
    Project = "Cloud-Resume"
  }
}

# ---> Creation of the item needed in DynamoDB for views count
resource "aws_dynamodb_table_item" "web_counter" {
  table_name = aws_dynamodb_table.views-counter.name
  hash_key   = aws_dynamodb_table.views-counter.hash_key

  item = <<ITEM
  {
    "counter": {"S": "web"},
    "views": {"N": "0"}
  }
ITEM
}