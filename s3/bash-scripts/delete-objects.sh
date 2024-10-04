#! /bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <bucket-name> <file-path>"
    exit 1
fi

BUCKET_NAME=$1
FILE_PATH=$2

# Transform the list of object keys into the format required by delete-objects command:
# 1. -n: Start with a null input
# 2. inputs: Read all inputs (object keys) as separate JSON values
# 3. .[] | {Key: .}: For each input, create an object with a "Key" field
# 4. []: Collect all these objects into an array
# 5. {Objects: ...}: Wrap the array in an object with an "Objects" field
aws s3api list-objects-v2 \
--bucket $BUCKET_NAME \
--output json \
--query 'Contents[].Key' \
| jq -n '{Objects: [inputs | .[] | {Key: .}]}' > delete-objects.json

aws s3api delete-objects \
 --bucket $BUCKET_NAME \
 --delete file://delete-objects.json

rm delete-objects.json