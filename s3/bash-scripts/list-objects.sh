#! /bin/bash

echo "Listing objects"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

BUCKET_NAME=$1

aws s3api list-objects-v2 \
 --bucket $BUCKET_NAME \
 --output table \
 --query 'Contents[].{Key: Key, Size: Size}'