# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# ALB Ingress Rules: Allow HTTP/HTTPS traffic
resource "aws_security_group_rule" "alb_ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_ingress_https" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}

# ALB Egress Rule: Allow outbound traffic to anywhere
resource "aws_security_group_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets           = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# Target Group for Web Servers
resource "aws_lb_target_group" "tg_web" {
  name     = "${var.project_name}-tg-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg-web"
  }
}

# Register Web Instances with Target Group
resource "aws_lb_target_group_attachment" "web_servers" {
  count            = length(var.web_instance_ids)
  target_group_arn = aws_lb_target_group.tg_web.arn
  target_id        = var.web_instance_ids[count.index]
  port            = 80
}

# ALB Listener for HTTP (Redirect to HTTPS)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# ALB Listener for HTTPS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy       = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web.arn
  }
}
