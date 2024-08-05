data "aws_iam_policy_document" "sh_sqs_policy" {
  statement {
    sid    = "shsqsstatement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:*"]
    resources = [
      aws_sqs_queue.aws_fifo_sqs_queue.arn
    ]
  }
}