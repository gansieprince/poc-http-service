# ECS Service
resource "aws_ecs_service" "frontend_web_service" {
  name            = "frontend-web-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.frontend_web_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_task_pub_sg.id]
    subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id] 
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.http_tg.arn
    container_name   = "web-container"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.http_alb_listener]
}

# ECS Task Definition
resource "aws_ecs_task_definition" "frontend_web_task" {
  family                   = "frontend_app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.frontend_role.arn

  container_definitions = jsonencode([{
    name      = "web-container"
    image     = "hashicorp/http-echo"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
}]
    command = [
        "-listen=:8080",
        "-text=hello world"
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.web.name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_cloudwatch_log_group" "web" {
  name              = "/ecs/${local.name}-web-lg"
  retention_in_days = 30
}