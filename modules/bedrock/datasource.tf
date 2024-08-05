##  model id

data "aws_bedrock_foundation_model" "sonnet_model" {
  model_id = var.bedrock_sonnet_model_id
}

