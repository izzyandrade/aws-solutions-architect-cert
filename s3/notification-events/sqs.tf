data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:s3-event-notification-queue"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.example.arn]
    }
  }
}

resource "aws_sqs_queue" "queue" {
  name   = "s3-event-notification-queue"
  policy = data.aws_iam_policy_document.queue.json
}
