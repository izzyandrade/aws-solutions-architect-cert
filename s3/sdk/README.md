# S3 Bucket Creator

This project contains a Python script to create an S3 bucket using the AWS SDK (Boto3).

## Prerequisites

- Python 3.7 or higher
- AWS account with appropriate permissions to create S3 buckets
- AWS Access Key ID and Secret Access Key

## Setup

1. Create a virtual environment:
   ```
   python -m venv .venv
   ```

2. Activate the virtual environment:
   - On Windows:
     ```
     .venv\Scripts\activate
     ```
   - On macOS and Linux:
     ```
     source .venv/bin/activate
     ```

3. Install the required packages:
   ```
   pip install -r requirements.txt
   ```

4. Create a `.env` file based on the `.env.example` file and add your AWS credentials:
   ```
   cp .env.example .env
   ```
   Edit the `.env` file and replace the placeholder values with your actual AWS credentials.

## Usage

To create an S3 bucket, run the following command:

```
python create-bucket.py <bucket-name> [--region <region-name>]
- `<bucket-name>`: The name of the S3 bucket you want to create (required).
- `--region`: The AWS region where you want to create the bucket (optional, default is 'sa-east-1').`
```