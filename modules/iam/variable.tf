variable "aws_iam_role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "iam_policy_arn_s3" {
  type = string
}

variable "iam_policy_arn_sqs" {
  type = string
}

variable "iam_policy_arn_bedrock" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "aws_iam_ecs_task_role_name" {
  type = string
}

variable "assume_role_policy_ecs" {
  type = string
}

variable "iam_policy_arn_sqs_readonly" {
  type = string
}

variable "aws_iam_ecs_task_execution_role_name" {
  type = string
}

variable "iam_policy_arn_ec2_registery_readonly" {
  type = string
}

variable "iam_policy_arn_ecs_task_execution_role" {
  type = string
}