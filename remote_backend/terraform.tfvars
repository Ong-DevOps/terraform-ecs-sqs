region                                  = "us-east-1"
profile                                 = "invoice-cg"
bucket_name                             = "invoice-terraform-state-backend-bucket-123"
aws_s3_bucket_backend                   = "invoice-terrafom-s3-backend"
aws_s3_bucket_versioning_status         = "Enabled"
dynamodb_table_name                     = "terraform_state"
aws_dynamodb_table_terraform_state_lock = "DynamoDB-Terraform-State-Lock-Table"
