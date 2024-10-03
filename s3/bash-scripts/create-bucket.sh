#! /bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

BUCKET_NAME=$1

echo "Creating bucket $BUCKET_NAME"
echo "Region: sa-east-1"

aws s3api create-bucket \
 --bucket $BUCKET_NAME \
 --region sa-east-1 \
 --create-bucket-configuration LocationConstraint=sa-east-1 \
 --query 'Location' \
 --output text
