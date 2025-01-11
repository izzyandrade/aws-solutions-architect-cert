## Create a bucket

```bash
aws s3api create-bucket --bucket encryption-fun-s3-izzy1 --create-bucket-configuration LocationConstraint=sa-east-1
```

## Create and upload file

```bash
echo "hi I am Izzy" > hello.txt
aws s3 cp hello.txt s3://encryption-fun-s3-izzy1/hello.txt
```

## Enable encryption on file (using AWS managed key with KMS)

```bash
aws s3api put-object \
--bucket encryption-fun-s3-izzy1 \
--key hello.txt \
--body hello.txt \
--server-side-encryption aws:kms \
--ssekms-key-id bdca5696-a300-42f4-854d-34eb2d0a9d1f
```

## Enable encryption using customer managed key (SSE-C)

First create a key

```bash
openssl rand 32 -out sse-c-key.txt
```

Then upload the file with the key

```bash
aws s3api put-object \
--bucket encryption-fun-s3-izzy1 \
--key hello-sse-c.txt \
--body hello-sse-c.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key fileb://sse-c-key.txt
```

Notice that if you try to download the file, you will get an error.

```bash
aws s3 cp s3://encryption-fun-s3-izzy1/hello-sse-c.txt .
```

You can download the file with the key

```bash
aws s3 cp s3://encryption-fun-s3-izzy1/hello-sse-c.txt . --sse-c AES256 --sse-c-key fileb://sse-c-key.txt
```
