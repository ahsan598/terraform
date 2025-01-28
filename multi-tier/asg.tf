resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-template-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "your-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.web_sg.id]
  }

  user_data = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y nginx
                systemctl start nginx
                systemctl enable nginx
              EOF

  tags = {
    Name = "web-template"
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = aws_subnet.public_subnet[*].id
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}