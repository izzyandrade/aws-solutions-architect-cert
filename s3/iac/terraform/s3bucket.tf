resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-izzy1"
  force_destroy = true
  tags = {
    Name = "My TF Test Bucket Izzy1"
  }
}