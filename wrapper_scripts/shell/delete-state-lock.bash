#!/bin/bash

set -euo pipefail

read -p "Enter the namespace: " NAMESPACE

PREFIX=cloud-platform-terraform-state/cloud-platform-environments

for key in "${PREFIX}/live-1.cloud-platform.service.justice.gov.uk/${NAMESPACE}/terraform.tfstate-md5" "${PREFIX}/live-1.cloud-platform.service.justice.gov.uk/${NAMESPACE}/terraform.tfstate"; do
	json='{"LockID":{"S":"'${key}'"}}'

	aws dynamodb delete-item \
		--region eu-west-1 \
		--table-name cloud-platform-environments-terraform-lock \
		--key $json
done
