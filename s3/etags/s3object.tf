resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example-etags.bucket
  key    = "myfile.txt"
  source = "myfile.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("myfile.txt")
}