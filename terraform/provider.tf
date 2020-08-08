# provider.tf

# Provider Configuration - AWS
provider "aws" {
  region                  = var.AWS_REGION
  shared_credentials_file = var.AWS_CRED
}
