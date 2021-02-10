resource "aws_kinesis_stream" "TMNL_stream" {
  name             = var.kinesis_stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period
  encryption_type = var.encryption_type
  kms_key_id = var.kms_key_id
}

resource "aws_kinesis_firehose_delivery_stream" "TMNL_Dstream" {
  name        = var.kineis_firhose_DStream
  destination = "s3"

  s3_configuration {
    role_arn   = "aws_iam_role.firehose_role.arn"
    bucket_arn = "aws_s3_bucket.kinesis_bucket.arn"
    }
}
