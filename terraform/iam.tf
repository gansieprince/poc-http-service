resource "aws_iam_role" "frontend_role" {
  name = "frontend-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"  
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "frontend_policy" {
  name = "frontend-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sqs:ReceiveMessage",
          "sqs:SendMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"

        ],
        Resource = "${aws_sqs_queue.frontend_to_backend.arn}"
      },
     {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParameterHistory"
        ],
        Resource = "${aws_ssm_parameter.http_postgres_password.arn}"
      }, 
     {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query"

        ],
        Resource = "${aws_dynamodb_table.session_metadata.arn}" 
      },      
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*" 
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${aws_cloudwatch_log_group.web.arn}:log-stream:*" 
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "frontend_policy_attach" {
  role       = aws_iam_role.frontend_role.name
  policy_arn = aws_iam_policy.frontend_policy.arn
}

