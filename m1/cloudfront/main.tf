locals {
  s3_origin_id = "myS3Origin"          # I don't know about this
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.comment
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.domain-name
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
}


#error :reqired attribute not set this is due to Cache behavior with precedence 1 isnot set. To eliminate this error you should add Cache behavior with precedence 1

#error one or more origin or origin group does not exist


#error the origin domain name does not reffer to valid s3 bukcet