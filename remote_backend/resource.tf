resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(local.common_tags, {
    Name = var.aws_s3_bucket_backend
  })
}

resource "aws_s3_bucket_policy" "backend-s3-bucket-policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.backend-s3-bucket-policy-document.json
}

resource "aws_s3_bucket_versioning" "versioning_on_bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning_status
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = var.dynamodb_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(local.common_tags, {
    Name = var.aws_dynamodb_table_terraform_state_lock
  })
}