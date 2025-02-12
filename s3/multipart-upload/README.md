# Initiate

In MacOS, generate a new 50MB file with

```bash
mkfile 50m testfile.txt
```

# Split the file into 10MB parts

```bash
split -b 10m -d testfile.txt testfile-part-
```

# Create a new bucket

```bash
aws s3 mb s3://multipart-fun-izzy-123
```

# Create a new multipart upload

```bash
aws s3api create-multipart-upload --bucket multipart-fun-izzy-123 --key 'testfile.txt'
```

> make sure to grab the uploadID:
> EWFh5gEBQRUjAdoeLWZPMffZ8kDiRPJwA1LmH092VjigeWtSiUk8Wt.yVvTR3z3iV7RClkdvosX\_\_T4N4X9fBp1DF4G5yJB35SElbkNNSWnPniz6DQg8imQf.Y_4EFTG

# Upload a part

```bash
export UPLOAD_ID=EWFh5gEBQRUjAdoeLWZPMffZ8kDiRPJwA1LmH092VjigeWtSiUk8Wt.yVvTR3z3iV7RClkdvosX__T4N4X9fBp1DF4G5yJB35SElbkNNSWnPniz6DQg8imQf.Y_4EFTG

aws s3api upload-part --bucket multipart-fun-izzy-123 --key 'testfile.txt' --part-number 1 --body testfile-part-00 --upload-id "$UPLOAD_ID"
aws s3api upload-part --bucket multipart-fun-izzy-123 --key 'testfile.txt' --part-number 2 --body testfile-part-01 --upload-id "$UPLOAD_ID"
aws s3api upload-part --bucket multipart-fun-izzy-123 --key 'testfile.txt' --part-number 3 --body testfile-part-02 --upload-id "$UPLOAD_ID"
aws s3api upload-part --bucket multipart-fun-izzy-123 --key 'testfile.txt' --part-number 4 --body testfile-part-03 --upload-id "$UPLOAD_ID"
aws s3api upload-part --bucket multipart-fun-izzy-123 --key 'testfile.txt' --part-number 5 --body testfile-part-04 --upload-id "$UPLOAD_ID"
```

# List parts

```bash
aws s3api list-parts --bucket multipart-fun-izzy-123 --key 'testfile.txt' --upload-id "$UPLOAD_ID" --query 'Parts[].{PartNumber: PartNumber, Size: Size, ETag: ETag}'
```

> the output of this command needs to be saved to `mpustruct.json` as described here
> https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/complete-multipart-upload.html#examples:~:text=named%20mpustruct.-,mpustruct,-%3A

# Complete the upload

```bash
aws s3api complete-multipart-upload \
--multipart-upload file://mpustruct.json \
--bucket multipart-fun-izzy-123 \
--key 'testfile.txt' \
--upload-id "$UPLOAD_ID"
```

# Cleanup

```bash
aws s3api delete-object --bucket multipart-fun-izzy-123 --key 'testfile.txt'
aws s3api delete-bucket --bucket multipart-fun-izzy-123
```
