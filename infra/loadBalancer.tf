resource "aws_lb" "djangoLoadBalancer" {
  name               = "ecs-django-loadBalancer"
  security_groups    = [aws_security_group.appPublicLoadBalancer.id]
  subnets            = [module.vpc.public_subnets]
}

resource "aws_lb_target_group" "loadBalancerTargetGroup" {
  name     = "ecs-django-loadBalancer"
  port     = 8000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "httpLoadBalacerListener" {
  load_balancer_arn = aws_lb.djangoLoadBalancer.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loadBalancerTargetGroup.arn
  }
}

output "loadBalancerOutput" {
  value = aws_lb.djangoLoadBalancer.dns_name
}