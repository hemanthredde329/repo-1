resource "aws_kms_key" "TMNL_key" {
  description             = var.description
  deletion_window_in_days = var.deletion_window
  key_usage = var.key_usage
  customer_master_key_spec = var.customer_key_spec
  is_enabled = var.is_enaled
}

resource "aws_kms_alias" "TMNL_key_alias" {
  name          = var.name
  target_key_id = var.target_key_id
}