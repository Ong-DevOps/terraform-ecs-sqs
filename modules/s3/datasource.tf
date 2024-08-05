data "aws_iam_policy_document" "s3-bucket-policy-document" {
  version = "2012-10-17"

  statement {
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*" # Allows GetObject on all objects in the bucket
    ]
  }
}
