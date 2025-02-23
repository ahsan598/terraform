
# Launch Template for Web and App Servers

resource "aws_launch_template" "multi_tier_lt" {
  name_prefix   = "${var.project_name}-multi-tier-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg_id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-multi-tier-instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "multi_tier_asg" {
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.multi_tier_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-multi-tier-asg"
    propagate_at_launch = true
  }
}

# Target Group for ALB
resource "aws_lb_target_group" "multi_tier_tg" {
  name     = "${var.project_name}-multi-tier-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Attach ASG to Target Group
resource "aws_autoscaling_attachment" "multi_tier_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.multi_tier_asg.id
  lb_target_group_arn    = aws_lb_target_group.multi_tier_tg.arn
}

# Security Group for ALB (allows HTTP & HTTPS)
resource "aws_security_group" "multi_tier_alb_sg" {
  name        = "${var.project_name}-multi-tier-alb-sg"
  description = "Allow HTTP and HTTPS"
  vpc_id      = var.vpc_id
}

# ALB Security Group Rules
resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.multi_tier_alb_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https" {
  security_group_id = aws_security_group.multi_tier_alb_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress" {
  security_group_id = aws_security_group.multi_tier_alb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.project_name}-multi-tier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.multi_tier_alb_sg.id]
  subnets           = var.public_subnet_ids
}

# ALB Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}