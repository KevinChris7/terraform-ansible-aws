# outputs.tf

### Application Outputs ###

# Load Balancer DNS Output
output "alb_dns" {
  value       = aws_lb.alb.dns_name
  description = "Load Balancer DNS"
}

# Load Balancer ARN Output
output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "Load Balancer ARN"
}

# Webserver1 Instance 
output "Web_Server1" {
  value       = aws_instance.webserver1.public_ip
  description = "Web_Server1 IP"
}

# Webserver2 Instance 
output "Web_Server2" {
  value       = aws_instance.webserver2.public_ip
  description = "Web_Server2 IP"
}

# 
output "VPC" {
  value       = aws_security_group.web_sec_gp.vpc_id
  description = "VPC Id"
}