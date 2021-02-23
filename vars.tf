# S3 variables

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

#-------------------------------------------
# Kinesis Variables

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
default = "NONE"
}

variable "kms_key_id" {
default = "aws_kms_key.TMNL_key.key_id" #ikkada .id place lo key.id set chesa
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

#----------------------------------------
#KMS Variables

variable "description" {
default = "TMNL kms key"
}

variable "deletion_window" {
default = "10"
}

variable "key_usage" {
default = "ENCRYPT_DECRYPT"
}

variable "customer_key_spec" {
default = "RSA_3072"
}

variable "is_enaled" {
default = "true"
}

variable "name" {
default = "alias/TMNL_key_alias"
}

variable "target_key_id" {
default = "aws_kms_key.TMNL_key.id"
}

#CloudWatch Variales -------------------------

variable "alarm_name" {
default = "TMNL_alarm"
}

variable "comparison_operator" {
default = "LessThanThreshold"
}

variable "evaluation_periods" {
default = "2"
}

variable "metric_name" {
default = "CPUUtilization"
}

variable "namespace" {
default = "hmr_namespace"
}

variable "periods" {
default = "120"
}

variable "statistic" {
default = "Average"
}

variable "threshold" {
default = "80"
}

variable "alarm_description" {
default = "TMNL alarm"
}

variable "kinesis_alarm_name" {
default = "TMNL alarm"
}

variable "log_group" {
default = "aws_cloudwatch_log_group.TMNL.name"
}

variable "retention_days" {
default = "3"
}

variable "log_stream" {
default = "TMNL_log_stream"
}

#CloudFront Variables ------------------------------------------------


variable "comment" {
default = "TMNL"
}


variable "domain-name" {
default = "aws_s3_bucket.kinesis_bucket.website_endpoint"
}

variable "origin_id" {
default = "local.s3_origin_id"
}

variable "OAI" {
default = "origin-access-identity/cloudfront/E1GNX68OY6O4KU"
}

variable "enabled" {
default = "true"
}

variable "is_ipv6_enabled" {
default = "true"
}
variable "default_root_object" {
default = "index.html"
}

variable "allowed_methods" {
type = list(string)
default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
type = list(string)
default =  ["GET", "HEAD"]
}
variable "target_origin_id" {
default = "local.s3_origin_id"
}


variable "query_string" {
default = "false"
}

variable "forward_cookies" {
default = "none"
}

variable "viewer_protocol_policy" {
default = "allow-all"
}
variable "min_ttl" {
default = "0"
}

variable "default_ttl" {
default = "3600"
}

variable "max_ttl" {
default = "86400"
}

variable "allowed_methods1" {
description = "allowed methods for  ordered_cache_behavior"
type = list(string)
default = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods1" {
description = "cache methods for  ordered_cache_behavior"
type = list(string)
default = ["GET", "HEAD", "OPTIONS"]
}


variable "viewer_protocol_policy1" {
description = "viewer_protocol_policy for  ordered_cache_behavior"
default = "redirect-to-https"
}

variable "path_pattern" {
default = "*"
}

variable "path_pattern1" {
default = "content/*"
}





