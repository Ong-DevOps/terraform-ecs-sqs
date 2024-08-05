resource "aws_iam_role" "invoice-aws_iam_role" {
  name               = var.aws_iam_role_name
  assume_role_policy = var.assume_role_policy
  tags               = var.common_tags
  managed_policy_arns = [
    var.iam_policy_arn_s3,
    var.iam_policy_arn_sqs,
    var.iam_policy_arn_bedrock
  ]
}

resource "aws_iam_instance_profile" "aws_iam_role_for_ec2" {
  name = var.aws_iam_role_name
  role = aws_iam_role.invoice-aws_iam_role.name
  tags = var.common_tags
}

resource "aws_iam_role" "aws_ecs_task_role" {
  name               = var.aws_iam_ecs_task_role_name
  assume_role_policy = var.assume_role_policy_ecs
  tags               = var.common_tags
  managed_policy_arns = [
    var.iam_policy_arn_sqs_readonly
  ]
}

resource "aws_iam_role" "aws_ecs_task_execution_role" {
  name               = var.aws_iam_ecs_task_execution_role_name
  assume_role_policy = var.assume_role_policy_ecs
  tags               = var.common_tags
  managed_policy_arns = [
    var.iam_policy_arn_ec2_registery_readonly,
    var.iam_policy_arn_ecs_task_execution_role
  ]
}



