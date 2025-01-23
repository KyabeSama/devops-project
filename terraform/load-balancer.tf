resource "aws_lb" "eks" {
  name               = "eks-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eks_cluster_sg.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = false

  tags = {
    Name = "eks-load-balancer"
  }
}

resource "aws_lb_target_group" "eks" {
  name     = "eks-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "eks-target-group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.eks.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks.arn
  }
}

