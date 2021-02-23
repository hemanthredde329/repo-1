# S3 outputs

output "s3_bucket_arn"{
value = aws_s3_bucket.kinesis_bucket.arn     #do not put double quotes for values
}

output "s3_domain_name"{
value = aws_s3_bucket.kinesis_bucket.website_endpoint
}

#-------------------------

#IAM Output
output "role_arn" {
value = aws_iam_role.firehose_role.arn
}

#KMS Outputs---------------------------
output "kms_key_arn" {
value = aws_kms_key.TMNL_key.arn
}

output "kms_key_id" {
value = aws_kms_key.TMNL_key.id
}

#CloudWatch outputs

output "log_stream" {
value = aws_cloudwatch_log_group.TMNL.arn
}


output "log_group" {
value = aws_cloudwatch_log_group.TMNL.arn
}

#CloudFront Outputs -------------------------------------------------


output "cloufront_OAI"{
value = aws_cloudfront_origin_access_identity.OAI.cloudfront_access_identity_path
}

#api gateway outputs ---------------------------------------------

output "api_id" {
value = aws_apigatewayv2_api.TMNL_APIv2.id
}

output "api_stage_arn" {
value = aws_apigatewayv2_stage.TMNL_API_stage.arn
}

output "invoke_url" {
value = aws_apigatewayv2_stage.TMNL_API_stage.invoke_url
}

output "web_acl" {
value = aws_wafv2_web_acl.TMNL_WAF.id
}