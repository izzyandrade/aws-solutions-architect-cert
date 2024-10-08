import os
import boto3
from botocore.exceptions import ClientError
from dotenv import load_dotenv

def create_s3_bucket(bucket_name: str, region: str = 'sa-east-1') -> bool:
    """Create an S3 bucket in a specified region.

    :param bucket_name: Name of the bucket to create.
    :param region: AWS region to create the bucket in.
    :return: True if bucket is created successfully, else False.
    """
    load_dotenv()

    aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
    aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')

    if not aws_access_key_id or not aws_secret_access_key:
        print("Error: AWS credentials not found in environment variables.")
        return False

    try:
        s3_client = boto3.client('s3', region_name=region)
        location = {'LocationConstraint': region}
        s3_client.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location)
        print(f"Bucket '{bucket_name}' created successfully in {region}.")
        return True
    except ClientError as e:
        print(f"Error creating bucket: {e}")
        return False

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description='Create an S3 bucket.')
    parser.add_argument('bucket_name', type=str, help='Name of the bucket to create')
    parser.add_argument('--region', type=str, default='sa-east-1', help='AWS region to create the bucket in')
    parser.add_argument('--use-env', action='store_true', help='Use environment variables for AWS credentials')

    args = parser.parse_args()

    success = create_s3_bucket(args.bucket_name, args.region, args.use_env)
    exit(0 if success else 1)
