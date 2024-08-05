region  = "us-east-1"
profile = "invoice-cg"


#  VPC  #####################################

aws_vpc_name                    = "invoice-management-vpc"
aws_vpc_cidr                    = "10.0.0.0/16"
aws_enable_dns_hostnames        = true
no-of-private-subnet            = null
aws_private_subnet_cidr_newbits = 4
aws_private_subnet_name         = "invoice-management-private-subnet"
no-of-public-subnet             = null
aws_public_subnet_cidr_newbits  = 4
aws_public_subnet_name          = "invoice-management-public-subnet"
aws_internet_gateway_name       = "invoice-management-vpc-igw"
aws_public_rt_name              = "invoice-management-vpc-public-rt"
aws_private_rt_name             = "invoice-management-vpc-private-rt"
vpc_endpoint_sg_name            = "invoice-management-ecr-endpoint-sg"
vpc_ecr_endpoint_name_api       = "invoice-management-ecr-api-endpoint"
vpc_ecr_endpoint_name_dkr       = "invoice-management-ecr-dkr-endpoint"
vpc_endpoint_sg_description     = "invoice-management-ecr-endpoint-sg"




#   RDS  ####################################


rds_sg_name                           = "invoice-management-aurora-rds-sg"
description_rds_sg                    = "invoice-management-aurora-rds-sg"
aws_rds_db_subnet_group_name          = "invoice-management-aurora-rds-subnet-group"
aws_rds_egine                         = "aurora-postgresql"
rds-cluster-identifier                = "invoice-management-production-aurora-rds"
rds-instance-class                    = "db.t4g.large"
rds_engine_version_postgres           = "14.9"
aws_rds_delete_automated_backups      = true
aws_rds_deletion_protection           = true
aurora_instance_count                 = 1
rds-engine-mode                       = "provisioned"
aws_rds_backup_retention_period       = 35
aws_rds_preferred_backup_window       = "02:00-03:00"
aws_rds_postgres_port                 = 5432
aws_rds_skip_final_snapshot           = true
aws_rds_storage_encrypted             = true
aws_rds_any_changes_apply_immediately = true
rds_ca_cert_identifier                = "rds-ca-rsa2048-g1"
performance_insights_enabled          = true
rds_db_name                           = "invoice_management_db"
aws_rds_master_username               = "postgres"    ### change this master_username
aws_rds_master_password               = "Admin123789" ### change this master_password
rds_aurora_publicly_accessible        = true
rds_sg_ec2_ingress_description        = "invoice-management-ec2-sg"


#   EC2  #####################################

ec2_name              = "invoice-management"
ec2_type              = "t3.large" ### change to "t3.large"
ec2_sg_name           = "invoice-management-ec2-sg"
aws_ec2_key_pair_name = "invoice-management-key"
ec2_public_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXqzEEzfjlOCsoVhI/WvKA84dGrhvQWd489tjcWYzFq0zVZcdPzf+g5Wss057q/TfYeQTgFGALzj3BHvRBaiAwTiokO9tHJ9SY59RXhsAEFIZ1p8xD4jiKG762b6Hr60ueeSqkNCOSEpoL3ibFIsPrmOPpbo5nwtaDCz2OwixGkhC6WTvRB9t4GK02muuKKpXFxt2ioqymbRlvHjUykj8ucXhywbcU83tYv4VL0Nf0NYdV+3lPVU0KMRpeK9o1BLlFEv/CG8g1DclURR6Mv5KW0FzBCQTfkp7G5eUYNQKeJZUvJLKfk7Rz/ItSlJSN0kOZHQDRCecopxHsRkZPs4KwgeS/jZkOKtQfQzjtS/W746WDPvydnATA5vbjRAFBxPKgJlcPlI8QTfsDXOh6NzQ/pWxpCrMDbbi7hJ6PWCGav8ReAhjTbuVEe1LGRQ6Hsc9FZF7xFu46yMRBndjqHY+lFUlk0ewSaTllr+EuwSzdoVbvL5NqB5JksUK2YgSrbXM= ongraph@ongraph-HP-280-G3-MT"
aws_ec2_user_data     = <<-EOF
#!/bin/bash -ex

apt update
apt install nginx -y

echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /var/www/html/index.html 
systemctl enable nginx
systemctl start nginx

echo '#!/bin/bash

QUEUE_NAME="new-invoice-management.fifo"
REGION="us-east-1"
RDS_CLUSTER_IDENTIFIER="invoice-management-production-aurora-rds"
S3_BUCKET_NAME="invoice-management-docs-test"


SQS_URL=$(aws sqs get-queue-url --queue-name "$QUEUE_NAME" --region "$REGION" --output text --query "QueueUrl")
RDS_ENDPOINT_URL=$(aws rds describe-db-clusters --db-cluster-identifier "$RDS_CLUSTER_IDENTIFIER" --query "DBClusters[0].Endpoint" --output text)

echo "SQS_URL=$SQS_URL" > .env
echo "RDS_ENDPOINT_URL=$RDS_ENDPOINT_URL" >> .env
echo "S3_BUCKET_NAME=$S3_BUCKET_NAME" >> .env' > aws_env.sh

bash aws_env.sh

apt install python3.10-venv -y
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
screen -d -m python3 manage.py runserver 0.0.0.0:8000
EOF


#   IAM   #####################################

aws_iam_role_name                      = "new-invoice-management-ec2-instance-role"
assume_role_policy                     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
iam_policy_arn_s3                      = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
iam_policy_arn_bedrock                 = "arn:aws:iam::aws:policy/AmazonBedrockFullAccess"
iam_policy_arn_sqs                     = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
aws_iam_ecs_task_role_name             = "invoice-management-celery-task-role"
assume_role_policy_ecs                 = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
aws_iam_ecs_task_execution_role_name   = "invoice-management-celery-task-execution-role"
iam_policy_arn_sqs_readonly            = "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess"
iam_policy_arn_ec2_registery_readonly  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
iam_policy_arn_ecs_task_execution_role = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"




#  SQS   #####################################


sqs-fifo-queue-name                 = "new-invoice-management.fifo"
aws_sqs_delay_seconds               = 0
aws_sqs_max_message_size            = 262144
aws_sqs_message_retention_seconds   = 345600
aws_sqs_receive_wait_time_seconds   = 0
aws_sqs_fifo_queue                  = true
aws_sqs_content_based_deduplication = true
aws_sqs_visibility_timeout_seconds  = 300



#  SNS   #####################################


aws_sns_topic_name      = "invoice-management-sqs-queue-depth-sns-topic"
aws_sns_delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    }
  }
}
EOF
aws_sns_display_name    = "Invoice-Management-SQS-Queue-Depth"


#  CloudWatch    #####################################


aws_cloudwatch_sqs_queue_depth_alarm_name     = "invoice-management-sqs-queue-depth-alarm"
aws_cloudwatch_comparison_operator            = "GreaterThanThreshold"
aws_cloudwatch_evaluation_periods             = "1"
aws_cloudwatch_interval_period                = "10"
aws_cloudwatch_metric_name_sqs                = "ApproximateNumberOfMessagesNotVisible"
aws_cloudwatch_namespace                      = "AWS/SQS"
aws_cloudwatch_metric_statistic               = "Average"
aws_cloudwatch_threshold_value                = "8"
aws_cloudwatch_metric_treat_missing_data      = "missing"
aws_cloudwatch_actions_enabled                = "true"
aws_cloudwatch_sqs_queue_depth_alarm_name_low = "invoice-management-sqs-queue-depth-alarm-low"
aws_cloudwatch_comparison_operator_low        = "LessThanThreshold"
aws_cloudwatch_evaluation_periods_low         = "5"
aws_cloudwatch_interval_period_low            = "60"
aws_cloudwatch_threshold_value_low            = "8"
aws_cloudwatch_metric_statistic_low           = "Average"





#   ECS     #####################################

ecs_cluster_name      = "new-invoice-management-fargate-cluster"
aws_task_family_name  = "invoice-management-celery-fargate-task-definition"
container_cpu         = "8193"  ## 1vCPU = 1024units,  for 8vCPUs put "8193" 
container_memory      = "16384" ## 1GB = 1024MB,  for 16GB put "16384"
ecs_sg_name           = "invoice-management-cluster-ec2-instance-sg"
ecs_sg_description    = "invoice-management-cluster-ec2-instance-sg"
ecs_service_name      = "invoice-management-celery-fargate-service"
ecs_container_name    = "celery"
scaling_max_capacity  = 5
scaling_min_capacity  = 1
scale_in_policy_name  = "invoice-management-celery-scale-in-policy"
scale_out_policy_name = "invoice-management-celery-scale-out-policy"




#   ECR     #####################################

repository_names     = "invoice-management-repo"
image_tag_mutability = "MUTABLE"
scan_on_push         = false
repository_tags = {
  "Name" = "invoice-management-repo"
}


#   S3     #####################################

bucket_name = "invoice-management-docs-test"


#   Docker     #####################################


docker_context  = "../docker-image-nginx/zul-m.github.io/" ## change this context
docker_filename = "Dockerfile"


#   Bedrock     #####################################


bedrock_sonnet_model_id = "anthropic.claude-3-sonnet-20240229-v1:0"

