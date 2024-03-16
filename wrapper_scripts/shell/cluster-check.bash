#!/bin/bash

tfplan(){
  # Run terraform plan and store the output in a file
  go run ~/.cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
    exit 1
  fi
  terraform plan -out=/tmp/plan.out > /dev/null 2>&1
}

tfapply(){
  # Run terraform apply using the plan file
  go run ~/.cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
    exit 1
  fi
  terraform apply /tmp/plan.out
}