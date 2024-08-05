output "cloudwatch_sqs_depth" {
  value = aws_cloudwatch_metric_alarm.sqs-queue-depth-alert.arn
}