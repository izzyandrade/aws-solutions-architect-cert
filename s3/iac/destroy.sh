#!/bin/bash

echo "Destroying stack"

STACK_NAME=$1

aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
    --region sa-east-1