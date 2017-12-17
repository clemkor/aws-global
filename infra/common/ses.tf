data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "email_bucket" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["ses.amazonaws.com"]
      type = "Service"
    }

    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${var.email_bucket_name}/*"]

    condition {
      test = "StringEquals"
      values = ["${data.aws_caller_identity.current.account_id}"]
      variable = "aws:Referer"
    }
  }
}

resource "aws_s3_bucket" "email_bucket" {
  bucket = "${var.email_bucket_name}"
}

resource "aws_s3_bucket_policy" "email_bucket" {
  bucket = "${aws_s3_bucket.email_bucket.id}"
  policy = "${data.aws_iam_policy_document.email_bucket.json}"
}

resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = "${module.dns_zones.public_zone_id}"
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = "600"
  records = ["${aws_ses_domain_identity.domain.verification_token}"]
}

resource "aws_route53_record" "mx" {
  zone_id = "${module.dns_zones.public_zone_id}"
  name = "${var.domain_name}"
  type = "MX"
  ttl = "3600"
  records = [
    "1 inbound-smtp.eu-west-1.amazonaws.com."
  ]
}

resource "aws_ses_receipt_rule_set" "admin" {
  rule_set_name = "default-rule-set"
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = "${aws_ses_receipt_rule_set.admin.rule_set_name}"
}

resource "aws_ses_domain_identity" "domain" {
  domain = "${var.domain_name}"
}

resource "aws_ses_receipt_rule" "store" {
  name          = "store"
  rule_set_name = "${aws_ses_receipt_rule_set.admin.rule_set_name}"
  recipients    = ["admin@${var.domain_name}"]
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name = "${var.email_bucket_name}"
    object_key_prefix = "admin/"
    position = 1
  }
}
