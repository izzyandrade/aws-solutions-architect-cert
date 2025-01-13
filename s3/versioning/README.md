## Create a bucket

```bash
aws s3api create-bucket --bucket versioning-fun-s3-izzy1 --region us-east-1
```

## Enable versioning on the bucket

```bash
aws s3api put-bucket-versioning --bucket versioning-fun-s3-izzy1 --versioning-configuration Status=Enabled
```

## Upload a file to the bucket

```bash
echo "version 1.0" > hello.txt
aws s3 cp hello.txt s3://versioning-fun-s3-izzy1/
```

## Upload a new version of the file

```bash
echo "version 2.0" > hello.txt
aws s3 cp hello.txt s3://versioning-fun-s3-izzy1/
```

## You can now list versions of the object

```bash
aws s3api list-object-versions --bucket versioning-fun-s3-izzy1 --prefix hello.txt
```

Notice that two versions of the file are listed.

## Get content of a specific version

```bash
aws s3api get-object --bucket versioning-fun-s3-izzy1 --key hello.txt --version-id 8eqD5dkk22HMfbkaUaYlSLwZoTOIgBlK
```

Notice that the content of the file is the version 1.0 content.

## Delete a specific version

```bash
aws s3api delete-object --bucket versioning-fun-s3-izzy1 --key hello.txt --version-id 8eqD5dkk22HMfbkaUaYlSLwZoTOIgBlK
```

## Now lets add another version of the file

```bash
echo "version 3.0" > hello.txt
aws s3 cp hello.txt s3://versioning-fun-s3-izzy1/
```

## Now lets delete without specifying a version

```bash
aws s3api delete-object --bucket versioning-fun-s3-izzy1 --key hello.txt
```

Notice that the latest version of the file is deleted and a Delete Marker is created.

## You can now list versions of the object

```bash
aws s3api list-object-versions --bucket versioning-fun-s3-izzy1 --prefix hello.txt
```
