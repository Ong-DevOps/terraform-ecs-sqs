##   modules  

##  VPC   #################################

module "vpc" {
  source = "./modules/vpc"

  aws_vpc_name                    = var.aws_vpc_name
  aws_vpc_cidr                    = var.aws_vpc_cidr
  aws_enable_dns_hostnames        = var.aws_enable_dns_hostnames
  common_tags                     = local.common_tags
  no-of-private-subnet            = var.no-of-private-subnet
  aws_private_subnet_cidr_newbits = var.aws_private_subnet_cidr_newbits
  aws_private_subnet_name         = var.aws_private_subnet_name
  no-of-public-subnet             = var.no-of-public-subnet
  aws_public_subnet_cidr_newbits  = var.aws_public_subnet_cidr_newbits
  aws_public_subnet_name          = var.aws_public_subnet_name
  aws_internet_gateway_name       = var.aws_internet_gateway_name
  aws_public_rt_name              = var.aws_public_rt_name
  aws_private_rt_name             = var.aws_private_rt_name
  aws_region                      = var.region
  ecs_sg_id                       = module.ecs.ecs_sg_id
  vpc_endpoint_sg_name            = var.vpc_endpoint_sg_name
  vpc_ecr_endpoint_name_dkr       = var.vpc_ecr_endpoint_name_dkr
  vpc_ecr_endpoint_name_api       = var.vpc_ecr_endpoint_name_api
  vpc_endpoint_sg_description     = var.vpc_endpoint_sg_description

}

##   RDS   ################################

module "rds" {
  source = "./modules/rds"

  aws_vpc_id                            = module.vpc.aws_vpc.id
  rds_sg_name                           = var.rds_sg_name
  description_rds_sg                    = var.description_rds_sg
  common_tags                           = local.common_tags
  ingress_rules_rds                     = local.ingress_rules_rds
  ec2_sg_id                             = module.ec2.ec2_sg_id
  aws_rds_subnet_ids                    = module.vpc.public_subnets_ids
  aws_rds_db_subnet_group_name          = var.aws_rds_db_subnet_group_name
  aws_rds_egine                         = var.aws_rds_egine
  rds_azs_list                          = module.vpc.rds_available_az
  rds-cluster-identifier                = var.rds-cluster-identifier
  rds-instance-class                    = var.rds-instance-class
  rds_engine_version_postgres           = var.rds_engine_version_postgres
  aws_rds_delete_automated_backups      = var.aws_rds_delete_automated_backups
  aws_rds_deletion_protection           = var.aws_rds_deletion_protection
  aurora_instance_count                 = var.aurora_instance_count
  rds_db_name                           = var.rds_db_name
  rds-engine-mode                       = var.rds-engine-mode
  aws_rds_backup_retention_period       = var.aws_rds_backup_retention_period
  aws_rds_preferred_backup_window       = var.aws_rds_preferred_backup_window
  aws_rds_postgres_port                 = var.aws_rds_postgres_port
  aws_rds_skip_final_snapshot           = var.aws_rds_skip_final_snapshot
  aws_rds_storage_encrypted             = var.aws_rds_storage_encrypted
  aws_rds_any_changes_apply_immediately = var.aws_rds_any_changes_apply_immediately
  rds_ca_cert_identifier                = var.rds_ca_cert_identifier
  performance_insights_enabled          = var.performance_insights_enabled
  aws_rds_master_password               = var.aws_rds_master_password
  aws_rds_master_username               = var.aws_rds_master_username
  rds_aurora_publicly_accessible        = var.rds_aurora_publicly_accessible
  aws_rds_tags                          = local.common_tags
  aws_rds_instance_tags                 = local.common_tags
  rds_sg_ec2_ingress_description        = var.rds_sg_ec2_ingress_description
  ecs_sg_id                             = module.ecs.ecs_sg_id

}


##  EC2   ##################################

module "ec2" {
  source = "./modules/ec2"

  ec2_name              = var.ec2_name
  ec2_type              = var.ec2_type
  common_tags           = local.common_tags
  aws_vpc_id            = module.vpc.aws_vpc.id
  ingress_rules_ec2     = local.ingress_rules_ec2
  ec2_sg_name           = var.ec2_sg_name
  aws_public_subents    = module.vpc.public_subnets_ids
  aws_ec2_key_pair_name = var.aws_ec2_key_pair_name
  ec2_public_key        = var.ec2_public_key
  aws_ec2_user_data     = var.aws_ec2_user_data
  aws_iam_role_for_ec2  = module.iam.aws_iam_role_for_ec2_name
  depends_on            = [module.rds, module.sqs]
}


##   IAM   ##################################

module "iam" {
  source = "./modules/iam"

  aws_iam_role_name                      = var.aws_iam_role_name
  assume_role_policy                     = var.assume_role_policy
  iam_policy_arn_s3                      = var.iam_policy_arn_s3
  iam_policy_arn_sqs                     = var.iam_policy_arn_sqs
  iam_policy_arn_bedrock                 = var.iam_policy_arn_bedrock
  common_tags                            = local.common_tags
  aws_iam_ecs_task_role_name             = var.aws_iam_ecs_task_role_name
  assume_role_policy_ecs                 = var.assume_role_policy_ecs
  iam_policy_arn_sqs_readonly            = var.iam_policy_arn_sqs_readonly
  aws_iam_ecs_task_execution_role_name   = var.aws_iam_ecs_task_execution_role_name
  iam_policy_arn_ec2_registery_readonly  = var.iam_policy_arn_ec2_registery_readonly
  iam_policy_arn_ecs_task_execution_role = var.iam_policy_arn_ecs_task_execution_role

}




##   SQS  ###############################

module "sqs" {
  source = "./modules/sqs"

  sqs-fifo-queue-name                 = var.sqs-fifo-queue-name
  aws_sqs_delay_seconds               = var.aws_sqs_delay_seconds
  aws_sqs_max_message_size            = var.aws_sqs_max_message_size
  aws_sqs_message_retention_seconds   = var.aws_sqs_message_retention_seconds
  aws_sqs_receive_wait_time_seconds   = var.aws_sqs_receive_wait_time_seconds
  aws_sqs_fifo_queue                  = var.aws_sqs_fifo_queue
  aws_sqs_content_based_deduplication = var.aws_sqs_content_based_deduplication
  aws_sqs_visibility_timeout_seconds  = var.aws_sqs_visibility_timeout_seconds
  common_tags                         = local.common_tags
}


##  SNS  ##############################################


module "sns" {
  source = "./modules/sns"

  aws_sns_topic_name      = var.aws_sns_topic_name
  aws_sns_delivery_policy = var.aws_sns_delivery_policy
  aws_sns_display_name    = var.aws_sns_display_name


}


##  CloudWatch  ##############################################


module "cloudwatch" {
  source = "./modules/cloudwatch"

  aws_cloudwatch_sqs_queue_depth_alarm_name     = var.aws_cloudwatch_sqs_queue_depth_alarm_name
  aws-sqs-queue_name                            = var.sqs-fifo-queue-name
  aws_cloudwatch_comparison_operator            = var.aws_cloudwatch_comparison_operator
  aws_cloudwatch_evaluation_periods             = var.aws_cloudwatch_evaluation_periods
  aws_cloudwatch_interval_period                = var.aws_cloudwatch_interval_period
  aws_cloudwatch_metric_name_sqs                = var.aws_cloudwatch_metric_name_sqs
  aws_cloudwatch_namespace                      = var.aws_cloudwatch_namespace
  aws_cloudwatch_metric_statistic               = var.aws_cloudwatch_metric_statistic
  aws_cloudwatch_threshold_value                = var.aws_cloudwatch_threshold_value
  aws_cloudwatch_metric_treat_missing_data      = var.aws_cloudwatch_metric_treat_missing_data
  aws_sns_arn                                   = module.sns.aws_sns_arn
  aws_cloudwatch_actions_enabled                = var.aws_cloudwatch_actions_enabled
  aws_cloudwatch_sqs_queue_depth_alarm_name_low = var.aws_cloudwatch_sqs_queue_depth_alarm_name_low
  aws_cloudwatch_comparison_operator_low        = var.aws_cloudwatch_comparison_operator_low
  aws_cloudwatch_evaluation_periods_low         = var.aws_cloudwatch_evaluation_periods_low
  aws_cloudwatch_interval_period_low            = var.aws_cloudwatch_interval_period_low
  aws_cloudwatch_metric_statistic_low           = var.aws_cloudwatch_metric_statistic_low
  aws_cloudwatch_threshold_value_low            = var.aws_cloudwatch_threshold_value_low
  common_tags                                   = local.common_tags
  ecs_service_scale_in_arn                      = module.ecs.ecs_service_scale_in_arn
  ecs_service_scale_out_arn                     = module.ecs.ecs_service_scale_out_arn
}


##  ECS  ##############################################


module "ecs" {
  source = "./modules/ecs"

  ecs_cluster_name                = var.ecs_cluster_name
  aws_task_family_name            = var.aws_task_family_name
  container_cpu                   = var.container_cpu
  container_memory                = var.container_memory
  aws_ecs_task_role_arn           = module.iam.aws_iam_role_for_task_role
  aws_ecs_task_execution_role_arn = module.iam.aws_iam_role_for_execution_task_role
  ecs_service_public_subnets      = module.vpc.rds_public_subnets_ids
  aws_vpc_id                      = module.vpc.aws_vpc.id
  ingress_rules_ecs               = local.ingress_rules_ecs
  ecs_sg_name                     = var.ecs_sg_name
  common_tags                     = local.common_tags
  ecs_sg_description              = var.ecs_sg_description
  ecs_service_name                = var.ecs_service_name
  container_name                  = var.ecs_container_name
  ecr_image_url                   = module.ecr.ecr_image_url
  scaling_max_capacity            = var.scaling_max_capacity
  scaling_min_capacity            = var.scaling_min_capacity
  scale_in_policy_name            = var.scale_in_policy_name
  scale_out_policy_name           = var.scale_out_policy_name


}


##  ECR  ##############################################


module "ecr" {
  source = "./modules/ecr"

  repository_names     = var.repository_names
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = var.scan_on_push
  repository_tags      = var.repository_tags
  common_tags          = local.common_tags
  region               = var.region
  aws_profile          = var.profile


}



##  S3   ##############################################


module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  common_tags = local.common_tags
}



##  Bedrock   ##############################################


module "bedrock" {
  source = "./modules/bedrock"

  bedrock_sonnet_model_id = var.bedrock_sonnet_model_id
}

