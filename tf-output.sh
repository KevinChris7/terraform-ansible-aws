#!/bin/bash

cd terraform
terraform output --json > ../test/profile/files/terraform.json
echo "Terraform Output Copied to Inspec file"
