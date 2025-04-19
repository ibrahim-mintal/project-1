# Create Load Balancer (ALB)
#-----------------------------------------------------------------#
resource "aws_lb" "myelb" {
  name                       = "ALB-ibrahim"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg-http.id]
  subnets                    = [module.network.public_subnet1_id, module.network.public_subnet2_id] #From outputs of network module
  enable_deletion_protection = false
  tags = {
  Name = "Ibrahim App" }
}

#==========================================================================#

# Create Target Group
#-----------------------------------------------------------------#
resource "aws_lb_target_group" "target_Group" {
  name     = "TG-ibrahim"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
  health_check {
    protocol = "HTTP"
    path     = "/"
  }
  tags = {
    Name = "TG-ibrahim"
  }
}
#==========================================================================#

# Create Listener for ALB
#-----------------------------------------------------------------#
resource "aws_lb_listener" "target_Group" {
  load_balancer_arn = aws_lb.myelb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_Group.arn
  }
}
