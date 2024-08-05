variable "ec2_type" {
  type = string
}

variable "ec2_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "aws_vpc_id" {
  type = string
}

variable "ingress_rules_ec2" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
}

variable "ec2_sg_name" {
  type = string
}

variable "aws_public_subents" {
  type = list(string)
}

variable "aws_ec2_key_pair_name" {
  type = string
}

variable "ec2_public_key" {
  type = string
}

variable "aws_ec2_user_data" {
  type = string
}

variable "aws_iam_role_for_ec2" {
  type = string
}