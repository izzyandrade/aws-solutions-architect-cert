## Create a bucket

```bash
aws s3api create-bucket --bucket lifecycle-fun-s3-izzy1 --create-bucket-configuration LocationConstraint=sa-east-1
```

## Create a lifecycle policy

```bash
aws s3api put-bucket-lifecycle-configuration --bucket lifecycle-fun-s3-izzy1 --lifecycle-configuration file://lifecycle.json
```

## Cleanup

```bash
aws s3 rb s3://lifecycle-fun-s3-izzy1
```
