# Creating the security group resource for PUBLIC subnet. 
resource "aws_security_group" "appPublicLoadBalancer" {
  name        = "appPublicLoadBalancer_ECS"
  vpc_id      = module.vpc_id #Notice that is the VPC module that we created at VPC.tf
}

#Creating ingress (input) rule for VPC
resource "aws_security_group_rule" "ingressRule_appPublicLoadBalancer" { 
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.appPublicLoadBalancer.id
}

#Creating egress(output) rule for VPC
resource "aws_security_group_rule" "egressRule_appPublicLoadBalancer" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.appPublicLoadBalancer.id                       
}

##################################################################################


#Creating the security group resource for PRIVATE subnet. 
resource "aws_security_group" "appPrivateLoadBalancer" {
  name        = "appPrivateLoadBalancer_ECS"
  vpc_id      = module.vpc_id #Notice, that is the VPC module that we created at VPC.tf
}

#Creating ingress (input) rule for VPC
resource "aws_security_group_rule" "ingressRule_appPrivateLoadBalancer" { 
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.appPublicLoadBalancer.id /*Here we are saying that only IP Adresses that was liberated on Public
                                                                           Load Balancer will be allowed to access the private network.*/
  security_group_id = aws_security_group.appPrivateLoadBalancer.id
}

#Creating egress(output) rule for VPC
resource "aws_security_group_rule" "egressRule_appPrivateLoadBalancer" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.appPrivateLoadBalancer.id                       
}