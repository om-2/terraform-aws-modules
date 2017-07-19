resource "aws_s3_bucket" "bucket" {
    bucket = "${var.prefix}-${var.service_name}-logs"
    acl = "private"
    lifecycle_rule {
        id = "expire-all"
        prefix = "/"
        enabled = "true"

        expiration {
            days = "${var.expiration_days}"
        }
    }
}
