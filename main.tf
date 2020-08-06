module "infrastructure" {
  source = "./modules/infrastructure"

  AWS_REGION     = var.AWS_REGION
  AWS_CRED       = var.AWS_CRED
  VPC_CIDR       = var.VPC_CIDR
  PUBLIC_CIDR    = var.PUBLIC_CIDR
  PRIVATE_CIDR_A = var.PRIVATE_CIDR_A
  PRIVATE_CIDR_B = var.PRIVATE_CIDR_B
  VPC_DNS_HOST   = var.VPC_DNS_HOST
}

