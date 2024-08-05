resource "aws_sqs_queue" "aws_fifo_sqs_queue" {
  name                        = var.sqs-fifo-queue-name
  delay_seconds               = var.aws_sqs_delay_seconds
  max_message_size            = var.aws_sqs_max_message_size
  message_retention_seconds   = var.aws_sqs_message_retention_seconds
  receive_wait_time_seconds   = var.aws_sqs_receive_wait_time_seconds
  fifo_queue                  = var.aws_sqs_fifo_queue
  content_based_deduplication = var.aws_sqs_content_based_deduplication
  visibility_timeout_seconds  = var.aws_sqs_visibility_timeout_seconds

  tags = merge(var.common_tags, {
    Name = var.sqs-fifo-queue-name
  })
}


resource "aws_sqs_queue_policy" "sh_sqs_policy" {
  queue_url = aws_sqs_queue.aws_fifo_sqs_queue.id
  policy    = data.aws_iam_policy_document.sh_sqs_policy.json
}

