resource "aws_launch_template" "frontend" {
  name_prefix   = "frontend-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.frontend.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-instance"
    }
  }

  user_data = filebase64("frontend-user-data.sh")
}

resource "aws_autoscaling_group" "frontend" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = aws_subnet.public[*].id
  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.frontend_tg.arn]

  tag {
    key                 = "Name"
    value               = "frontend-asg"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "backend" {
  name_prefix   = "backend-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.backend.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-instance"
    }
  }

  user_data = filebase64("backend-user-data.sh")
}

resource "aws_autoscaling_group" "backend" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = aws_subnet.private_app[*].id
  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.backend_tg.arn]

  tag {
    key                 = "Name"
    value               = "backend-asg"
    propagate_at_launch = true
  }
}
