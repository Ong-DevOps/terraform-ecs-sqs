variable "ecs_cluster_name" {
  type = string
}

variable "container_cpu" {
  type = string
}

variable "aws_task_family_name" {
  type = string
}

variable "container_memory" {
  type = string
}

variable "aws_ecs_task_role_arn" {
  type = string
}

variable "aws_ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_service_public_subnets" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
}

variable "aws_vpc_id" {
  type = string
}

variable "ingress_rules_ecs" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
}

variable "ecs_sg_name" {
  type = string
}


variable "ecs_sg_description" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecr_image_url" {
  type = string
}

variable "container_name" {
  type = string
}

variable "scaling_max_capacity" {
  type = number
}

variable "scaling_min_capacity" {
  type = number
}

variable "scale_in_policy_name" {
  type = string
}

variable "scale_out_policy_name" {
  type = string
}

