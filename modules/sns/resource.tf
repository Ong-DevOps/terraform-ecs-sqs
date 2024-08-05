resource "aws_sns_topic" "invoice-sns-topic" {
  name            = var.aws_sns_topic_name
  delivery_policy = var.aws_sns_delivery_policy
  display_name    = var.aws_sns_display_name
}
