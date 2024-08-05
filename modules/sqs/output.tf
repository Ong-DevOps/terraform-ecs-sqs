output "sqs_fifo_url" {
  value = aws_sqs_queue.aws_fifo_sqs_queue.url
}