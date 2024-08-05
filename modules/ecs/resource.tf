resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  tags = var.common_tags
}

# ECS Task Definitions
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.aws_task_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  task_role_arn            = var.aws_ecs_task_role_arn
  execution_role_arn       = var.aws_ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name  = var.container_name,
      image = var.ecr_image_url,
    },
  ])
  tags = var.common_tags
}


resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  vpc_id      = var.aws_vpc_id
  description = var.ecs_sg_description

  dynamic "ingress" {
    for_each = var.ingress_rules_ecs
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, {
    Name = var.ecs_sg_name
  })
}

# ECS Services
resource "aws_ecs_service" "ecs_service_invoice" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets          = var.ecs_service_public_subnets
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.ecs_task_definition]
  tags = merge(var.common_tags, {
    Name = var.ecs_service_name
  })
}


resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.scaling_max_capacity
  min_capacity       = var.scaling_min_capacity
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service_invoice.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags               = var.common_tags
}

resource "aws_appautoscaling_policy" "ecs_autopscale_in_policy" {
  name               = var.scale_in_policy_name
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "ExactCapacity"
    # cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_autopscale_out_policy" {
  name               = var.scale_out_policy_name
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 8
      scaling_adjustment          = 2 ## if the metric value goes above 8, it will trigger scaling adjustments.
    }

    step_adjustment {
      metric_interval_lower_bound = 8
      metric_interval_upper_bound = 16
      scaling_adjustment          = 3
    }

    step_adjustment {
      metric_interval_lower_bound = 16
      metric_interval_upper_bound = 24
      scaling_adjustment          = 4
    }

    step_adjustment {
      metric_interval_lower_bound = 24
      scaling_adjustment          = 5
    }
  }
}
