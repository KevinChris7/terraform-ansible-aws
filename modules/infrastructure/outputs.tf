# outputs.tf

########### Infrastructure Outputs ###########

output "vpc" {
  value       = aws_vpc.primary_vpc.arn
  description = "ARN of VPC"
}

output "vpc_cidr" {
  value       = aws_vpc.primary_vpc.cidr_block
  description = "CIDR Block of VPC"
}

output "vpcid" {
  value       = aws_vpc.primary_vpc.id
  description = "ID of VPC"
}

output "publicsubnet" {
  value = aws_subnet.public_subnet.id
}

output "publicsubnet2" {
  value = aws_subnet.public_subnet2.id
}

output "privatesubnet1" {
  value = aws_subnet.private_subnetA.id
}

output "privatesubnet2" {
  value = aws_subnet.private_subnetB.id
}

# output "azs" {
#     value = aws_availability_zones.present_azs 
# }