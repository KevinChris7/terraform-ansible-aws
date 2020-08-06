# variables.tf

# Variable for AWS REGION
variable "AWS_REGION" {
  default = "ap-south-1"
}

# Variable for AWS Credentials
variable "AWS_CRED" {
  default = "/kevin/.aws/credentials"
}

# Variable for VPC CIDR 
variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

# Variable for Public CIDR 
variable "PUBLIC_CIDR" {
  default = "10.0.1.0/24"
}

# Variable for Private CIDRs
variable "PRIVATE_CIDR_A" {
  default = "10.0.2.0/24"
}

variable "PRIVATE_CIDR_B" {
  default = "10.0.3.0/24"
}

# Variable for DNS HOST
variable "VPC_DNS_HOST" {
  default = true
}
