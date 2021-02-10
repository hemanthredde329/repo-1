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
