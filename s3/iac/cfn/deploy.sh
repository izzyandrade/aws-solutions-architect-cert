#!/bin/bash

echo "Deploying stack"

aws cloudformation deploy \
    --template-file "$(dirname "$0")/template.yaml" \
    --stack-name my-example-stack \
    --region sa-east-1