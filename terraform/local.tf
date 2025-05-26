locals {
  name        = "${var.env}-${var.stack}"
  account_id  = data.aws_caller_identity.current.account_id
  domain_name = "${var.product}.${var.env}.${var.domain_name}"
  tags = {
    Name    = local.name
    Env     = var.env
    Product = var.product
    Stack   = var.stack
  }
}