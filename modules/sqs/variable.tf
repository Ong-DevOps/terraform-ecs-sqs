variable "sqs-fifo-queue-name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "aws_sqs_delay_seconds" {
  type = number
}

variable "aws_sqs_max_message_size" {
  type = number
}

variable "aws_sqs_message_retention_seconds" {
  type = number
}

variable "aws_sqs_receive_wait_time_seconds" {
  type = number
}

variable "aws_sqs_fifo_queue" {
  type    = bool
  default = true
}

variable "aws_sqs_content_based_deduplication" {
  type    = bool
  default = true
}

variable "aws_sqs_visibility_timeout_seconds" {
  type = number
}