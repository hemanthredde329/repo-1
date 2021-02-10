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


