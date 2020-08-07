# outputs.tf

### Application Outputs ###

# Load Balancer DNS Output
output "alb-dns" {
  value = aws_lb.alb.dns_name
}