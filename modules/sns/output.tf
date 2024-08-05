output "aws_sns_arn" {
  value = aws_sns_topic.invoice-sns-topic.arn
}