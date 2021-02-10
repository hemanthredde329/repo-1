
variable "comment" {
default = "TMNL"
}


variable "domain-name" {
default = "aws_s3_bucket.kinesis_bucket.bucket_regional_domain_name"
}

variable "origin_id" {
default = "local.s3_origin_id"
}

variable "OAI" {
default = "aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path"
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





