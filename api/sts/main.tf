terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "sts_bucket" {
  bucket = "sts-fun-bucket-izzy-123"
}

//create a user to assign to the role
resource "aws_iam_user" "sts_user" {
  name = "sts_user"
}

# Create the role with trust relationship
resource "aws_iam_role" "sts_role" {
  name = "sts_role"
  
  # Trust policy - allows the user to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = aws_iam_user.sts_user.arn
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Create S3 access policy and attach it to the ROLE
resource "aws_iam_role_policy" "s3_access" {
  name = "s3_access"
  role = aws_iam_role.sts_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::sts-fun-bucket-izzy-123",
        "arn:aws:s3:::sts-fun-bucket-izzy-123/*"
      ]
    }]
  })
}

# Give the user permission to assume the role
resource "aws_iam_user_policy" "allow_assume_role" {
  name = "allow_assume_role"
  user = aws_iam_user.sts_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Resource = aws_iam_role.sts_role.arn
    }]
  })
}

# Delete access keys before user deletion
resource "null_resource" "delete_access_keys" {
  triggers = {
    user_name = aws_iam_user.sts_user.name
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      for key in $(aws iam list-access-keys --user-name ${self.triggers.user_name} --query 'AccessKeyMetadata[*].AccessKeyId' --output text); do
        aws iam delete-access-key --user-name ${self.triggers.user_name} --access-key-id $key
      done
    EOF
  }
}

