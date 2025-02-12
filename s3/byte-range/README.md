# Create a new bucket

```bash
aws s3 mb s3://byte-range-fun-izzy-123
```

# Create a new file

```bash
echo 'Hello, world!' > hello.txt
```

# Upload a file

```bash
aws s3 cp hello.txt s3://byte-range-fun-izzy-123/hello.txt
```

# Grab object range of bytes

```bash
aws s3api get-object --bucket byte-range-fun-izzy-123 --key hello.txt --range bytes=0-4 hello-range.txt
```

> notice this command will only grab the first bytes 0-4 of the file, that means "Hello"

# Cleanup

```bash
aws s3api delete-object --bucket byte-range-fun-izzy-123 --key hello.txt
aws s3api delete-bucket --bucket byte-range-fun-izzy-123
```
