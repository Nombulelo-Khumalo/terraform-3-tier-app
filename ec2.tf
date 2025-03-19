resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = "ami-0f9de6e2d2f067fca" 
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                  = aws_subnet.private[0].id
    security_groups            = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo systemctl start nginx
              EOF
            )



  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-server"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = aws_subnet.private[*].id

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "app-server-asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }
}

