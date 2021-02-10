resource "aws_cloudwatch_log_group" "TMNL_logs" {
  name = var.log_group
  retention_in_days = var.retention_days
  kms_key_id = var.kms_key_id

  tags = {
    Name = "TMNL_cloudwatch_log_group"
  }
}

resource "aws_cloudwatch_log_stream" "TMNL_log_stream" {
  name           = var.log_stream
  log_group_name = var.log_group
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

