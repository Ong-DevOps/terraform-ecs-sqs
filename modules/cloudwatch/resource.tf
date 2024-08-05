resource "aws_cloudwatch_metric_alarm" "sqs-queue-depth-alert" {
  alarm_name          = var.aws_cloudwatch_sqs_queue_depth_alarm_name
  comparison_operator = var.aws_cloudwatch_comparison_operator
  evaluation_periods  = var.aws_cloudwatch_evaluation_periods
  period              = var.aws_cloudwatch_interval_period
  metric_name         = var.aws_cloudwatch_metric_name_sqs
  namespace           = var.aws_cloudwatch_namespace
  statistic           = var.aws_cloudwatch_metric_statistic
  threshold           = var.aws_cloudwatch_threshold_value
  treat_missing_data  = var.aws_cloudwatch_metric_treat_missing_data
  dimensions = {
    "QueueName" : var.aws-sqs-queue_name
  }
  actions_enabled = var.aws_cloudwatch_actions_enabled
  alarm_actions   = [var.aws_sns_arn, var.ecs_service_scale_out_arn]
  tags = merge(var.common_tags, {
    Name = var.aws_cloudwatch_sqs_queue_depth_alarm_name
  })

}


resource "aws_cloudwatch_metric_alarm" "sqs-queue-depth-alarm-low" {
  alarm_name          = var.aws_cloudwatch_sqs_queue_depth_alarm_name_low
  comparison_operator = var.aws_cloudwatch_comparison_operator_low
  evaluation_periods  = var.aws_cloudwatch_evaluation_periods_low
  period              = var.aws_cloudwatch_interval_period_low
  metric_name         = var.aws_cloudwatch_metric_name_sqs
  namespace           = var.aws_cloudwatch_namespace
  statistic           = var.aws_cloudwatch_metric_statistic_low
  threshold           = var.aws_cloudwatch_threshold_value_low
  treat_missing_data  = var.aws_cloudwatch_metric_treat_missing_data
  dimensions = {
    "QueueName" : var.aws-sqs-queue_name
  }
  actions_enabled = var.aws_cloudwatch_actions_enabled
  alarm_actions   = [var.aws_sns_arn, var.ecs_service_scale_in_arn]
  tags = merge(var.common_tags, {
    Name = var.aws_cloudwatch_sqs_queue_depth_alarm_name_low
  })

}
