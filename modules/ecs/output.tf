output "ecs_service_scale_in_arn" {
  value = aws_appautoscaling_policy.ecs_autopscale_in_policy.arn
}

output "ecs_service_scale_out_arn" {
  value = aws_appautoscaling_policy.ecs_autopscale_out_policy.arn
}

# output "ecs_autoscale_policy" {
#   value = aws_appautoscaling_policy.ecs_autopscale_in_policy
# }

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}