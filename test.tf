provider "aws" {
access_key = "AKIAIIRDLTVVZGSEHOMA"
secret_key = "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"
region = "eu-central-1"
}

# S3 resourece

resource "aws_s3_bucket" "kinesis_bucket" {
  bucket = "hmrndsnjds187.s3.amazonaws.com"
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

#------------------------------
#KMS Resource

resource "aws_kms_key" "TMNL_key" {
  description             = var.description
  deletion_window_in_days = var.deletion_window
  key_usage = var.key_usage
  customer_master_key_spec = var.customer_key_spec
  is_enabled = var.is_enaled
}

resource "aws_kms_alias" "a" {
  name          = "alias/my-key-alias"
  target_key_id = aws_kms_key.TMNL_key.key_id     # key_id vundali not .id
}

#------------------------------
#IAM Reesource

resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


#-------------------------
# Kinesis Resource

resource "aws_kinesis_stream" "TMNL_stream" {
  name             = var.kinesis_stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period
  encryption_type = var.encryption_type
}

resource "aws_kinesis_firehose_delivery_stream" "TMNL_Dstream" {
  name        = var.kineis_firhose_DStream
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn     # do not use quotes here
    bucket_arn = aws_s3_bucket.kinesis_bucket.arn   # do not use quotes here
    }
}

#CloudWatch Resource ------------------------


resource "aws_cloudwatch_log_group" "TMNL" {
  name = "TMNL"
  retention_in_days = var.retention_days
}

resource "aws_cloudwatch_log_stream" "TMNL_Stream" {
  name           = "TMNL_Stream"
  log_group_name = aws_cloudwatch_log_group.TMNL.name
}


resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = var.alarm_name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                   = var.periods
  statistic                 = var.statistic
  threshold                 = var.threshold
  alarm_description         = var.alarm_description
}

#apigateway resoutrce------------------------------

resource "aws_apigatewayv2_api" "TMNL_APIv2" {
  name                       = "TMNL_APIv2"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_domain_name" "TMNL_domain_name" {
  domain_name = "www.hmrreddy.tk"

  domain_name_configuration {
    certificate_arn = "arn:aws:acm:eu-central-1:922930485874:certificate/94544c1f-f9a6-4527-a88b-9594041ffffe"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_stage" "TMNL_API_stage" {
  api_id = aws_apigatewayv2_api.TMNL_APIv2.id
  name   = "example-stage"
}


resource "aws_apigatewayv2_api_mapping" "TMNL_API_mapping" {
  api_id      = aws_apigatewayv2_api.TMNL_APIv2.id
  domain_name = aws_apigatewayv2_domain_name.TMNL_domain_name.id
  stage       = aws_apigatewayv2_stage.TMNL_API_stage.id
}

resource "aws_apigatewayv2_route" "TMNL_API_route" {
  api_id    = aws_apigatewayv2_api.TMNL_APIv2.id
  route_key = "$connect"
}

resource "aws_apigatewayv2_integration" "TMNL_API_integration" {
  api_id           = aws_apigatewayv2_api.TMNL_APIv2.id
  integration_type = "MOCK"  # I am getting error when integration type is AWS_PROXY error creating API Gateway v2 integration: BadRequestException: Invalid integration URI specified
}


#WAF Resource ----------------------------------------------

resource "aws_wafv2_web_acl" "TMNL_WAF" {
  name        = "TMNL_WAF"
  description = "WAF for cloudfront and api gateway"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = var.metric_name
      sampled_requests_enabled   = false
    }
}

resource "aws_wafv2_ip_set" "TMNL_ip_set" {
  name               = "TMNL_ip_set"
  description        = "TMNL IP set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["10.0.0.0/32", "192.168.0.0/32"]

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}




#Cloudfront Resource----------------------------------------

locals {
  s3_origin_id = "myS3Origin"          # I don't know about this
}

resource "aws_cloudfront_origin_access_identity" "OAI" {
  comment = var.comment
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "aws_s3_bucket.kinesis_bucket.website_endpoint"
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = var.OAI
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = "Some comment"
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.target_origin_id

    forwarded_values {
      query_string = var.query_string

      cookies {
        forward = var.forward_cookies
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = var.path_pattern
    allowed_methods  = var.allowed_methods1
    cached_methods   = var.cached_methods1
    target_origin_id = var.target_origin_id

    forwarded_values {
      query_string = var.query_string
      headers      = ["Origin"]

      cookies {
        forward = var.forward_cookies
      }
    }

    min_ttl                = var.min_ttl
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = var.viewer_protocol_policy1
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = var.path_pattern1
    allowed_methods  = var.allowed_methods1
    cached_methods   = var.cached_methods1
    target_origin_id = var.target_origin_id

    forwarded_values {
      query_string = var.query_string

      cookies {
        forward = var.forward_cookies
      }
    }

    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = true
    viewer_protocol_policy = var.viewer_protocol_policy1
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  web_acl_id = "18b4370f-a3fc-43a8-8b90-e12a2a821f15"
}
