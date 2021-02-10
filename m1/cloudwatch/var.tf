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
default = "TMNL_log_group"
}

variable "retention_days" {
default = "2"
}

variable "kms_key_id" {
value = "aws_kms_key.TMNL_key.id"
}

variable "log_stream" {
default = "TMNL_log_stream"
}


variable "sns_arn" {}

variable "delivery_stream_alarm_name" {}