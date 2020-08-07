# main.tf

### Infrastructure Module ###

module "infrastructure" {
  source = "./modules/infrastructure"

  AWS_REGION     = var.AWS_REGION
  AWS_CRED       = var.AWS_CRED
  VPC_CIDR       = var.VPC_CIDR
  PUBLIC_CIDR    = var.PUBLIC_CIDR
  PUBLIC_CIDR_B  = var.PUBLIC_CIDR_B
  PRIVATE_CIDR_A = var.PRIVATE_CIDR_A
  PRIVATE_CIDR_B = var.PRIVATE_CIDR_B
  VPC_DNS_HOST   = var.VPC_DNS_HOST
}

### Infrastructure Data Sources ###

# Data source - Availability Zones
data "aws_availability_zones" "present_azs" {
  state = "available"
}

# VPC data
data "aws_vpc" "vpc_input" {
  cidr_block = var.VPC_CIDR
  tags = {
    Name = "primary"
  }
  depends_on = [module.infrastructure.vpc]
}

# Public Subnet data
data "aws_subnet" "subnet_id_pub1_input" {
  vpc_id = data.aws_vpc.vpc_input.id
  tags = {
    Name = "PublicSubnet1"
  }
}

data "aws_subnet" "subnet_id_pub2_input" {
  vpc_id = data.aws_vpc.vpc_input.id
  tags = {
    Name = "PublicSubnet2"
  }
}

# Private Subnets data
data "aws_subnet" "subnet_id_priv1_input" {
  vpc_id = data.aws_vpc.vpc_input.id
  tags = {
    Name = "PrivateSubnet1"
  }
}

data "aws_subnet" "subnet_id_priv2_input" {
  vpc_id = data.aws_vpc.vpc_input.id
  tags = {
    Name = "PrivateSubnet2"
  }
}

### Application Resources ###

# ELB Security Group
resource "aws_security_group" "sg_alb" {
  name   = "sg_alb"
  vpc_id = data.aws_vpc.vpc_input.id
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "appalb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets            = [data.aws_subnet.subnet_id_pub1_input.id, data.aws_subnet.subnet_id_pub2_input.id]
}

# Application Load Balancer Target Group
resource "aws_lb_target_group" "alb_tg" {
  name     = "appalbtg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc_input.id
}

# Application Load Balancer Listener 
resource "aws_lb_listener" "elb_listen_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# Webserver Security Group
resource "aws_security_group" "web_sec_gp" {
  name   = "websecgrp"
  vpc_id = data.aws_vpc.vpc_input.id
  ingress {
    description     = "Inbound for Public Subnet"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.sg_alb.id]
    protocol        = "tcp"
  }
  ingress {
    description = "Inbound for Public Subnet"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"] //Need to give home network
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance Creation webserver1
resource "aws_instance" "webserver1" {
  ami                         = lookup(var.AMIS, var.AWS_REGION)
  availability_zone           = data.aws_availability_zones.present_azs.names[0]
  instance_type               = var.INSTANCE_TYPE
  key_name                    = var.KEY_PAIR
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web_sec_gp.id]
  subnet_id                   = data.aws_subnet.subnet_id_priv1_input.id
  tags = {
    Name = "webserverA"
  }
  user_data = file("apache.sh")
}

# Instance Creation webserver2
resource "aws_instance" "webserver2" {
  ami                         = lookup(var.AMIS, var.AWS_REGION)
  availability_zone           = data.aws_availability_zones.present_azs.names[1]
  instance_type               = var.INSTANCE_TYPE
  key_name                    = var.KEY_PAIR
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web_sec_gp.id]
  subnet_id                   = data.aws_subnet.subnet_id_priv2_input.id
  tags = {
    Name = "webserverB"
  }
  user_data = file("apache.sh")
}

# Application Load Balancer EC2 Attachment
resource "aws_lb_target_group_attachment" "alb_ec2_attach1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.webserver1.id
  port             = "80"
}

# Application Load Balancer EC2 Attachment
resource "aws_lb_target_group_attachment" "alb_ec2_attach2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.webserver2.id
  port             = "80"
}
