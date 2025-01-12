## Create a source and destination bucket

```bash
aws s3api create-bucket --bucket replication-fun-s3-izzy1 --create-bucket-configuration LocationConstraint=sa-east-1
```

```bash
aws s3api create-bucket --bucket replication-fun-s3-izzy2 --create-bucket-configuration LocationConstraint=sa-east-1
```

## Turn on S3 versioning for both buckets

````bash
aws s3api put-bucket-versioning --bucket replication-fun-s3-izzy1 --versioning-configuration Status=Enabled
    ```

```bash
aws s3api put-bucket-versioning --bucket replication-fun-s3-izzy2 --versioning-configuration Status=Enabled
````

## Create role and policy for S3 replication

```bash
aws iam create-policy --policy-name s3-replication-policy --policy-document file://policy.json

aws iam create-role --role-name s3-replication-role --assume-role-policy-document file://trust.json

aws iam attach-role-policy \
    --policy-arn arn:aws:iam::610742216056:policy/s3-replication-policy \
    --role-name s3-replication-role
```

## Enable bucket replication

```bash
aws s3api put-bucket-replication \
    --bucket replication-fun-s3-izzy1 \
    --replication-configuration file://replication.json
```

## Upload a file to the source bucket

```bash
aws s3 cp hello.txt s3://replication-fun-s3-izzy1/
```
