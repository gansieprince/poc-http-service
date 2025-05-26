resource "aws_sqs_queue" "frontend_to_backend" {
  name                      = "frontend-to-backend.fifo"
  fifo_queue                = true
  content_based_deduplication = true

  tags = {
    Name        = "frontend-to-backend"
    Environment = var.env
  }
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.frontend_to_backend_dead_letter.arn
    maxReceiveCount     = 5  # Messages will be moved to dead-letter queue after 5 failed attempts
  })
}

resource "aws_sqs_queue" "frontend_to_backend_dead_letter" {
  name                      = "frontend-to-backend-dead-letter.fifo"
  fifo_queue                = true
  content_based_deduplication = true

  tags = {
    Name        = "frontend-to-backend-dead-letter"
    Environment = var.env
  }
}



#The dynamodb table for the services and sqs queue for the shared services
resource "aws_dynamodb_table" "session_metadata" {
  name           = "session-metadata"
  billing_mode   = "PAY_PER_REQUEST"  # On-demand capacity
  hash_key       = "session_id"

  attribute {
    name = "session_id"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = {
    Name        = "session-metadata"
    Environment = var.env
  }
}


  