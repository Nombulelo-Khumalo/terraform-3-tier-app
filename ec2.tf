resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = "ami-830c94e3"  # Replace with a valid Ubuntu AMI for us-east-1
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                  = aws_subnet.private.id
    security_groups            = [aws_security_group.ec2_sg.id]
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo systemctl start nginx
              EOF

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
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.private.id]

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

