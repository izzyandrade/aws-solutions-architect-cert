## Execute the terraform script to create the resources

```bash
terraform init
terraform plan
terraform apply
```

## Create credentials for the sts_user

```bash
aws iam create-access-key --user-name sts_user
```

## Create and configure aws-vault profile for the sts_user

```bash
aws-vault add sts_user
```

## Authenticate with the sts_user and try to do a request

```bash
aws-vault exec sts_user -- aws s3 ls
```

> This will throw an error because the user is not authorized to do anything except operations in bucket sts-fun-bucket-izzy-123

## Make a request to the bucket using the sts_user credentials

```bash
aws s3 ls s3://sts-fun-bucket-izzy-123
```

## Upload test file to the bucket using the sts_user credentials

```bash
aws s3 cp test.txt s3://sts-fun-bucket-izzy-123
```

## Execute the terraform script to destroy the resources

```bash
terraform destroy
```
