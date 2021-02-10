variable "kinesis_stream_name" {
default = "TMNL_Kinesis_stream"
}

variable "shard_count" {
default = "1"
}

variable "retention_period" {
default = "48"
}

variable "encryption_type" {
default = "KMS"
}

variable "kms_key_id" {
default = "aws_kms_key.TMNL_key.id"
}

variable "kineis_firhose_DStream" {
default = "TMNL_kinesis_firhose_Dstream"
}

variable "role_arn" {
default = "aws_iam_role.firehose_role.arn"
}

variable "bucket_arn" {
default = "aws_s3_bucket.kinesis_bucket.arn"
}


#s3variables

variable "bucket_name" {
default = "hmrndsnjds187"
}

variable "acl" {
default = "private"
}

variable "rule_id" {
default = "hmr_life_cycle_rule"
}

variable "enalbe" {
default = "true"
}

variable "auto_clean" {
default = "true"
}

variable "prefix" {
default = "hmr_life_cycle_rule/"
}


variable "transition_days" {
default = "30"
}


variable "storage_class" {
default = "STANDARD_IA"
}

variable "storage_class2" {
default = "GLACIER"
}
