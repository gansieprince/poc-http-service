#The cloudwatch alarms will be created here
resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "RDSHighCPU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2                         # Only 1 period needed
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300                       # 5 minutes = 300 seconds
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when RDS CPU exceeds 80% for 5 minutes"
  alarm_actions       = [aws_sns_topic.rds_sqs_notifications.arn]
  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.http_cluster.cluster_identifier  # Use the cluster identifier from your RDS cluster 
  }
  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "sqs_queue_depth" {
  alarm_name          = "SQSQueueDepthHigh"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2                         # 2 periods of 5 mins = 10 mins
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 300                       # 5 minutes
  statistic           = "Average"
  threshold           = 100
  alarm_description   = "Alarm when SQS queue has more than 100 messages for 10 minutes"
  alarm_actions       = [aws_sns_topic.rds_sqs_notifications.arn]
  dimensions = {
    QueueName = aws_sqs_queue.frontend_to_backend.name            # Set this variable to your queue name (without the .fifo suffix if FIFO)
  }
  treat_missing_data = "notBreaching"
}

resource "aws_sns_topic" "rds_sqs_notifications" {
  name = "${var.cw_sns_topic}" # Set this variable to your SNS topic name
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.rds_sqs_notifications.arn
  protocol  = "email"
  endpoint  = "${var.email_endpoint}" # Set this variable to your email endpoint
}
