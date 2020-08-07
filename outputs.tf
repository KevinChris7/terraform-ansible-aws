# outputs.tf

### Application Outputs ###

# Load Balancer DNS Output
output "alb_dns" {
  value = aws_lb.alb.dns_name
}

# Webserver1 Instance 
output "Web_Server1" {
  value = aws_instance.webserver1.public_ip
}

# Webserver2 Instance 
output "Web_Server2" {
  value = aws_instance.webserver2.public_ip
}