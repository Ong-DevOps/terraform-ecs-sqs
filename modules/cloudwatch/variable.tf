variable "aws_cloudwatch_sqs_queue_depth_alarm_name" {
  type = string
}

variable "aws-sqs-queue_name" {
  type = string
}

variable "aws_cloudwatch_comparison_operator" {
  type = string
}

variable "aws_cloudwatch_evaluation_periods" {
  type = string
}

variable "aws_cloudwatch_interval_period" {
  type = string
}

variable "aws_cloudwatch_metric_name_sqs" {
  type = string
}

variable "aws_cloudwatch_namespace" {
  type = string
}

variable "aws_cloudwatch_metric_statistic" {
  type = string
}

variable "aws_cloudwatch_threshold_value" {
  type = string
}

variable "aws_cloudwatch_metric_treat_missing_data" {
  type = string
}

variable "aws_sns_arn" {
  type = string
}

variable "aws_cloudwatch_actions_enabled" {
  type = string
}

variable "aws_cloudwatch_sqs_queue_depth_alarm_name_low" {
  type = string
}

variable "aws_cloudwatch_comparison_operator_low" {
  type = string
}

variable "aws_cloudwatch_evaluation_periods_low" {
  type = string
}

variable "aws_cloudwatch_interval_period_low" {
  type = string
}

variable "aws_cloudwatch_metric_statistic_low" {
  type = string
}

variable "aws_cloudwatch_threshold_value_low" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "ecs_service_scale_in_arn" {
  type = string
}

variable "ecs_service_scale_out_arn" {
  type = string
}

# variable "ecs_autoscale_policy" {
#   type = string
# }