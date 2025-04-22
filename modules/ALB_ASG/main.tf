# Load Balancer (ALB) and Auto Scaling Group combined module

resource "aws_lb" "myelb" {
  name                       = "Ibrahim-ELB"
  load_balancer_type         = "application"
  security_groups            = var.lb_security_groups
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_deletion_protection
  
  tags = {
    Name = "Ibrahim App"
  }
}

resource "aws_lb_target_group" "target_Group" {
  name     = "TG-ibrahim"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

 tags = {
    Name = "TG-ibrahim"
  }
}


resource "aws_lb_listener" "target_Group" {
  load_balancer_arn = aws_lb.myelb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_Group.arn
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = "bastion-key"

  vpc_security_group_ids = var.instance_security_groups
    user_data = base64encode(var.user_data)


  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

 
}

resource "aws_autoscaling_group" "app" {
  name                = "asg-app"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = var.asg_subnets
  target_group_arns   = [aws_lb_target_group.target_Group.arn]
  health_check_type   = "EC2"
  force_delete        = true

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}
