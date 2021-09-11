resource "aws_alb" "nimble-lb" {
  name               = "nimble-ecs-lb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  tags = {
    "env"       = "dev"
    "createdBy" = "eyal"
  }
  security_groups = [aws_security_group.lb.id]
}

resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = aws_vpc.nimble-vpc.id
  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "env"       = "dev"
    "createdBy" = "eyal"
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "nimble-target-group"
  port        = "8080"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.nimble-vpc.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    matcher             = "200,301,302"
  }
}

resource "aws_alb_listener" "web-listener" {
  load_balancer_arn = aws_alb.nimble-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}