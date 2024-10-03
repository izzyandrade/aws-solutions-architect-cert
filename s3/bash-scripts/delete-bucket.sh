#! /bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

BUCKET_NAME=$1

echo "Deleting bucket $BUCKET_NAME"

aws s3api delete-bucket \
 --bucket $BUCKET_NAME \
 --output text
