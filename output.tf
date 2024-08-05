output "available_az" {
  value = module.vpc.available_az
}


output "aws_sqs_fifo_url" {
  value = module.sqs.sqs_fifo_url
}

output "aws_ecr_image_url" {
  value = module.ecr.ecr_image_url
}


output "rds_postgres_endpoint" {
  value = module.rds.rds_cluster_writer_endpoint
}

output "s3_invoice_doc_bucket" {
  value = module.s3.s3_invoice_doc_bucket
}

output "bedrock_sonnet_model_id" {
  value = module.bedrock.bedrock_sonnet_model_id
}
