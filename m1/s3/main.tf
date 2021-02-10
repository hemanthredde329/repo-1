resource "aws_s3_bucket" "kinesis_bucket" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = var.rule_id
    enabled = var.enalbe

    prefix = var.prefix

    tags = {
      "rule"      = var.rule_id
      "autoclean" = var.auto_clean
    }

    transition {
      days          = var.transition_days
      storage_class = var.storage_class
    }

    transition {
      days          = 60
      storage_class = var.storage_class2
    }

    expiration {
      days = 90
    }
  }
}