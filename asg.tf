resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = var.image_id # Amazon Linux 2023 in us-east-1
  instance_type = var.aws_instance_type
  key_name      = "bastion-key"

  vpc_security_group_ids = [aws_security_group.sg-http.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3
    echo "Hello from ASG instance: $(hostname -f)" > /home/ec2-user/index.html
    cd /home/ec2-user
    nohup python3 -m http.server 80 &
  EOF
  )

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ASG_Instance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "asg-app"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [module.network.private_subnet1_id, module.network.private_subnet2_id]
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
