output "s3_bucket_arn"{
value = "aws_s3_bucket.kinesis_bucket.arn"
}

output "s3_domain_name"{
value = "aws_s3_bucket.kinesis_bucket.bucket_regional_domain_name"
}


