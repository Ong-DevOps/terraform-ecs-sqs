#   providers    ###########################################

variable "region" {
  type = string
}

variable "profile" {
  type = string
}


#   VPC     ##################################################

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



#   RDS   ##########################################

variable "rds_sg_name" {
  type = string
}

variable "description_rds_sg" {
  type = string
}

variable "aws_rds_db_subnet_group_name" {
  type = string
}

variable "aws_rds_egine" {
  type = string
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

variable "aws_rds_any_changes_apply_immediately" {
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

variable "rds_sg_ec2_ingress_description" {
  type = string
}


#    EC2   ##############################################


variable "ec2_name" {
  type = string
}

variable "ec2_type" {
  type = string
}

variable "ec2_sg_name" {
  type = string
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



#   IAM   ##############################################


variable "aws_iam_role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "iam_policy_arn_s3" {
  type = string
}

variable "iam_policy_arn_sqs" {
  type = string
}

variable "iam_policy_arn_bedrock" {
  type = string
}

variable "aws_iam_ecs_task_role_name" {
  type = string
}

variable "assume_role_policy_ecs" {
  type = string
}

variable "iam_policy_arn_sqs_readonly" {
  type = string
}

variable "aws_iam_ecs_task_execution_role_name" {
  type = string
}

variable "iam_policy_arn_ecs_task_execution_role" {
  type = string
}

variable "iam_policy_arn_ec2_registery_readonly" {
  type = string
}


#   SQS   ##############################################


variable "aws_sqs_delay_seconds" {
  type = number
}

variable "aws_sqs_max_message_size" {
  type = number
}

variable "aws_sqs_message_retention_seconds" {
  type = number
}

variable "aws_sqs_receive_wait_time_seconds" {
  type = number
}

variable "sqs-fifo-queue-name" {
  type = string
}

variable "aws_sqs_fifo_queue" {
  type    = bool
  default = true
}

variable "aws_sqs_content_based_deduplication" {
  type    = bool
  default = true
}

variable "aws_sqs_visibility_timeout_seconds" {
  type = number
}




#   SNS   ##############################################


variable "aws_sns_topic_name" {
  type = string
}

variable "aws_sns_delivery_policy" {
  type = string
}

variable "aws_sns_display_name" {
  type = string
}



#   CloudWatch   ##############################################

variable "aws_cloudwatch_sqs_queue_depth_alarm_name" {
  type = string
}

variable "aws_cloudwatch_comparison_operator" {
  type = string
}

variable "aws_cloudwatch_evaluation_periods" {
  type = string
}

variable "aws_cloudwatch_interval_period" {
  type = string
}

variable "aws_cloudwatch_metric_name_sqs" {
  type = string
}

variable "aws_cloudwatch_namespace" {
  type = string
}

variable "aws_cloudwatch_metric_statistic" {
  type = string
}

variable "aws_cloudwatch_threshold_value" {
  type = string
}

variable "aws_cloudwatch_metric_treat_missing_data" {
  type = string
}

variable "aws_cloudwatch_actions_enabled" {
  type = string
}


variable "aws_cloudwatch_sqs_queue_depth_alarm_name_low" {
  type = string
}

variable "aws_cloudwatch_comparison_operator_low" {
  type = string
}

variable "aws_cloudwatch_evaluation_periods_low" {
  type = string
}

variable "aws_cloudwatch_interval_period_low" {
  type = string
}

variable "aws_cloudwatch_metric_statistic_low" {
  type = string
}

variable "aws_cloudwatch_threshold_value_low" {
  type = string
}


#   ECS   ##############################################

variable "ecs_cluster_name" {
  type = string
}

variable "aws_task_family_name" {
  type = string
}

variable "container_cpu" {
  type = string
}

variable "container_memory" {
  type = string
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

variable "ecs_container_name" {
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


#   ECR   ##############################################


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



#   S3   ##############################################


variable "bucket_name" {
  type = string
}


#   S3   ##############################################


variable "docker_context" {
  type = string
}

variable "docker_filename" {
  type = string
}


#   Bedrock   ##############################################


variable "bedrock_sonnet_model_id" {
  type = string
}
