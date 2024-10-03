#! /bin/bash

echo "Listing buckets"

aws s3api list-buckets | jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[] | .Name'