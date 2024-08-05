terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
  backend "s3" {
    bucket         = "invoice-terraform-state-backend-bucket-123"
    key            = "terraform/invoice-management/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = false
    dynamodb_table = "terraform_state"
    profile        = "invoice-cg"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}


provider "docker" {
  registry_auth {
    address  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
