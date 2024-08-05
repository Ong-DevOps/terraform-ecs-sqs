variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "aws_s3_bucket_backend" {
  type = string
}

variable "aws_s3_bucket_versioning_status" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "aws_dynamodb_table_terraform_state_lock" {
  type = string
}

