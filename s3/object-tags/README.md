## Create a bucket

```bash
aws s3api create-bucket --bucket s3-object-tags-fun-izzy-12345 --region sa-east-1 --create-bucket-configuration LocationConstraint=sa-east-1
```

## Upload a file to the bucket

```bash
echo "Hello World" > test-file.txt
aws s3 cp test-file.txt s3://s3-object-tags-fun-izzy-12345/test-file.txt
```

## Add tags to the file

```bash
aws s3api put-object-tagging \
    --bucket s3-object-tags-fun-izzy-12345 \
    --key test-file.txt \
    --tagging '{"TagSet": [{ "Key": "designation", "Value": "confidential" }]}'
```

## Cleanup

```bash
aws s3 rm s3://s3-object-tags-fun-izzy-12345/test-file.txt
aws s3 rb s3://s3-object-tags-fun-izzy-12345
```
