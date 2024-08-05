variable "aws_vpc_name" {
  type = string
}

variable "aws_vpc_cidr" {
  type = string
}

variable "aws_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "common_tags" {
  type = map(string)
}

variable "no-of-private-subnet" {
  type    = number
  default = null
}

variable "aws_private_subnet_cidr_newbits" {
  type    = number
  default = 4
}

variable "aws_private_subnet_name" {
  type = string
}

variable "no-of-public-subnet" {
  type    = number
  default = null
}

variable "aws_public_subnet_cidr_newbits" {
  type    = number
  default = 4
}

variable "aws_public_subnet_name" {
  type = string
}

variable "aws_internet_gateway_name" {
  type = string
}

variable "aws_public_rt_name" {
  type = string
}

variable "aws_private_rt_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}

variable "vpc_endpoint_sg_name" {
  type = string
}

variable "vpc_ecr_endpoint_name_dkr" {
  type = string
}

variable "vpc_ecr_endpoint_name_api" {
  type = string
}

variable "vpc_endpoint_sg_description" {
  type = string
}