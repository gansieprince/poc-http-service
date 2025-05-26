# ECS Cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "${local.name}-cluster"
}