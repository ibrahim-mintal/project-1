# Load Balancer (ALB) and Auto Scaling Group combined module

resource "aws_lb" "myelb" {
  name                       = var.lb_name
  internal                   = var.lb_internal
  load_balancer_type         = "application"
  security_groups            = var.lb_security_groups
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_deletion_protection
  tags                       = var.lb_tags
}

resource "aws_lb_target_group" "target_Group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    protocol = var.health_check_protocol
    path     = var.health_check_path
  }

  tags = var.target_group_tags
}

resource "aws_lb_listener" "target_Group" {
  load_balancer_arn = aws_lb.myelb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_Group.arn
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.instance_security_groups

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

 
}

resource "aws_autoscaling_group" "app" {
  name                = var.asg_name
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  desired_capacity    = var.asg_desired_capacity
  vpc_zone_identifier = var.asg_subnets
  target_group_arns   = [aws_lb_target_group.target_Group.arn]
  health_check_type   = var.asg_health_check_type
  force_delete        = var.asg_force_delete

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.asg_tag_name
    propagate_at_launch = true
  }
}
