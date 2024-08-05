variable "rds_sg_name" {
  type = string
}

variable "description_rds_sg" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "ingress_rules_rds" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
}

variable "ec2_sg_id" {
  type = string
}

variable "aws_rds_db_subnet_group_name" {
  type = string
}

variable "aws_rds_subnet_ids" {
  type = list(string)
}

variable "aws_rds_egine" {
  type = string
}

variable "rds_azs_list" {
  type = list(string)
}

variable "rds-cluster-identifier" {
  type = string
}

variable "rds-instance-class" {
  type = string
}

variable "rds_engine_version_postgres" {
  type = string
}

variable "aws_rds_delete_automated_backups" {
  type    = bool
  default = true
}

variable "aws_rds_deletion_protection" {
  type    = bool
  default = true
}

variable "aurora_instance_count" {
  description = "Number of Aurora DB instances in the cluster"
  type        = number
  default     = 1
}

variable "rds_db_name" {
  type = string
}

variable "rds-engine-mode" {
  type = string
}

variable "aws_rds_backup_retention_period" {
  type    = number
  default = 7
}

variable "aws_rds_preferred_backup_window" {
  type = string
}

variable "aws_rds_postgres_port" {
  type    = number
  default = 5432
}

variable "aws_rds_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "aws_rds_storage_encrypted" {
  type    = bool
  default = true
}

variable "aws_rds_any_changes_apply_immediately" {
  type    = bool
  default = true
}

variable "rds_ca_cert_identifier" {
  description = "CA certificate identifier for the Aurora DB cluster"
  type        = string
  default     = "rds-ca-rsa2048-g1"
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights for Aurora instances"
  type        = bool
  default     = true
}

variable "aws_rds_master_username" {
  type = string
}

variable "aws_rds_master_password" {
  type = string
}

variable "rds_aurora_publicly_accessible" {
  type = bool
}

variable "aws_rds_tags" {
  type = map(string)
}

variable "aws_rds_instance_tags" {
  type = map(string)
}

variable "rds_sg_ec2_ingress_description" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}