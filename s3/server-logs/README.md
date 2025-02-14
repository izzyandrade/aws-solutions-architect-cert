# Create source and destination buckets

```bash
aws s3 mb s3://server-logs-source-bucket-fun-izzy-123
aws s3 mb s3://server-logs-destination-bucket-fun-izzy-123
```

# Add a policy to the destination bucket

```bash
aws s3api put-bucket-policy --bucket server-logs-destination-bucket-fun-izzy-123 --policy file://policy.json
```

# Add logging to the source bucket

```bash
aws s3api put-bucket-logging --bucket server-logs-destination-bucket-fun-izzy-123 --bucket-logging-status file://logging.json
```

# Trigger logging by uploading a file

```bash
echo 'Hello, world!' > test.txt
aws s3api put-object --bucket server-logs-source-bucket-fun-izzy-123 --key test.txt --body test.txt
aws s3api get-object --bucket server-logs-source-bucket-fun-izzy-123 --key test.txt test-downloaded.txt
```

# Check the destination bucket for the log file

```bash
aws s3 ls s3://server-logs-destination-bucket-fun-izzy-123/Logs/
```

# Delete file and buckets

```bash
aws s3 rm s3://server-logs-source-bucket-fun-izzy-123/test.txt
aws s3 rm s3://server-logs-destination-bucket-fun-izzy-123 --recursive
aws s3 rb s3://server-logs-source-bucket-fun-izzy-123
aws s3 rb s3://server-logs-destination-bucket-fun-izzy-123
```
