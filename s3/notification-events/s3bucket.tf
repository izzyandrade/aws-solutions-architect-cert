resource "aws_s3_bucket" "example" {
  bucket = "s3-notification-events-fun-izzy-12345"
  force_destroy = true
  tags = {
    Name = "S3 Notification Events Izzy1"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.example.id

  topic {
    topic_arn = aws_sns_topic.topic.arn
    events    = ["s3:ObjectCreated:*"]
    filter_prefix = "topic/"
  }

  queue {
    id            = "any-upload-event"
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "queue/"
  }
}