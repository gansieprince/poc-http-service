# ECS Service
/*
resource "aws_ecs_service" "backend_app_service" {
  name            = "backend-app-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.backend_app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_task_prt_sg.id]
    subnets         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id] 
    assign_public_ip = false
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "backend_app_task" {
  family                   = "backend_app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512" 
  execution_role_arn       = aws_iam_role.backend_app_role.arn

  container_definitions = jsonencode([{
    name      = "app-container"
    image     = "nginx:alpine"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
}]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.backend.name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${local.name}-backend-lg"
  retention_in_days = 30
}
*/ 

#This code is commenetd out because it is not needed for the current setup.
# It is kept here for reference in case it is needed in the future.