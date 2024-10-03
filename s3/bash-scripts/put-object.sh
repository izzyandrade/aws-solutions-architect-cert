#! /bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bucket-name> <file-path>"
    exit 1
fi

BUCKET_NAME=$1
FILE_PATH=$2

aws s3api put-object \
 --bucket $BUCKET_NAME \
 --key $FILE_PATH \
 --body $FILE_PATH  