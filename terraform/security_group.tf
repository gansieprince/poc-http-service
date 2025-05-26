
#Security group for rds cluster
resource "aws_security_group" "http_rds_sg" {
  name        = "${local.name}-rds-sg"
  description = "rds sg"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for rule in var.rds_postgres_rules : rule.description => rule if rule.type == "ingress" }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = { for rule in var.rds_postgres_rules : rule.description => rule if rule.type == "egress" }

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}

#Security group for alb
resource "aws_security_group" "http_alb_sg" {
  name        = "${local.name}-alb-sg"
  description = "alb sg"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for rule in var.http_alb_rules : rule.description => rule if rule.type == "ingress" }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = { for rule in var.http_alb_rules : rule.description => rule if rule.type == "egress" }

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}

#Security group for ecs tasks in public subnet

resource "aws_security_group" "ecs_task_pub_sg" {
  name        = "${local.name}-ecs-taks-pub-sg"
  description = "ecs taks pub sg"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for rule in var.ecs_task_pub_sg_rules : rule.description => rule if rule.type == "ingress" }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = { for rule in var.ecs_task_pub_sg_rules : rule.description => rule if rule.type == "egress" }

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}

#Security group for ecs tasks in private subnet
/*
resource "aws_security_group" "ecs_task_prt_sg" {
  name        = "${local.name}-ecs-taks-prt-sg"
  description = "ecs taks prt sg"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for rule in var.ecs_task_prt_sg_rules : rule.description => rule if rule.type == "ingress" }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = { for rule in var.ecs_task_prt_sg_rules : rule.description => rule if rule.type == "egress" }

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      description = egress.value.description
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}
*/
