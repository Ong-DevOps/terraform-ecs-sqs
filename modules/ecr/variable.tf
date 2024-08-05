variable "repository_names" {
  description = "Names of the ECR repositories"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability for the ECR repositories"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = false
}

variable "repository_tags" {
  description = "Tags for the ECR repositories"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

variable "common_tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "aws_profile" {
  type = string
}
