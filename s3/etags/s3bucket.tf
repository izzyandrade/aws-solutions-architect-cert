resource "aws_s3_bucket" "example-etags" {
  bucket = "my-tf-test-bucket-etags-izzy"
  force_destroy = true
  tags = {
    Name = "My TF Test Bucket Etags Izzy"
  }
}