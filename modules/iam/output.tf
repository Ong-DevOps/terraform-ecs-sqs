output "aws_iam_role_for_ec2_name" {
  value = aws_iam_instance_profile.aws_iam_role_for_ec2.name
}

output "aws_iam_role_for_task_role" {
  value = aws_iam_role.aws_ecs_task_role.arn
}

output "aws_iam_role_for_execution_task_role" {
  value = aws_iam_role.aws_ecs_task_execution_role.arn
}

