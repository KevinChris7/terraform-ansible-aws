#!/bin/bash

cd terraform
terraform output --json > ../test/devtest/files/terraform.json
echo "Terraform Output Copied to Inspec file"
