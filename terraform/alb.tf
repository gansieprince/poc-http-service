resource "aws_lb" "http_alb" {
  name               = "${local.name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups    = [aws_security_group.http_alb_sg.id]
  enable_deletion_protection = false
}
resource "aws_lb_listener" "http_alb_listener" {
  load_balancer_arn = aws_lb.http_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.http_tg.arn
  }
}

resource "aws_lb_target_group" "http_tg" {
  name = "http-tg"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  health_check {
    path = "/"
    interval = 30
  }
}