# Lambda function that will make use of Gateway Endpoints

## Overview

This Lambda function will make use of Gateway Endpoints to list objects from an S3 bucket.

To make this work, first you need to provision an AWS VPC with a S3 Gateway Endpoint.

The setup I normally use for the VPC is:

- 1 VPC
- 1 AZ
- 0 Public Subnet
- 1 Private Subnet
- 1 Route Table
- 1 S3 Gateway Endpoint

The S3 Gateway Endpoint must be created in the VPC, and must have the private subnet Route Table attached to it. 

## S3 Bucket

Just create a new S3 bucket, and make sure you use that name whenever you see me using `gateway-endpoint-example-izzy` in the code.

You can add one object to be listed as well.

## Lambda Function

The Lambda function will be deployed in the private subnet, and will make use of the S3 Gateway Endpoint to list objects from the S3 bucket.

First create a new Lambda function, and in the configuration, select the VPC and the private subnet.

In the Lambda function, you must add permissions to its role to access S3, so that it can list objects from the S3 bucket. The only necessary permissions are `s3:ListBucket` and `s3:GetObject`.

Then, inside this project, you can cd into the `lambda-project` folder and run `npm install` to install the dependencies.

After that, you can run `zip -r function.zip index.js node_modules` to zip the function.

And finally, you can upload the function to AWS Lambda using the .zip

## Testing

You can test the function by calling it from the AWS Lambda console, or by using the AWS CLI.

```bash
aws lambda invoke --function-name gateway-endpoint-example response.json
```

And then you can check the response in the `response.json` file that will be generated.