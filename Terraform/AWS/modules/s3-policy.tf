data "aws_canonical_user_id" "current" {}


module "s3-bucket-VPC-Flow-logs" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "1.15.0"
  acl                     = "log-delivery-write"
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "revvit2uat-${var.env}-vpc-flow-logs"
  ignore_public_acls      = true
  force_destroy           = true
  restrict_public_buckets = true
  versioning = {
    enabled    = true
    mfa_delete = false
  }
   object_lock_configuration = {
    object_lock_enabled = "Enabled"
  }

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = false
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  
  tags = {
    name         = "${var.env}-vpc-flow-logs"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}