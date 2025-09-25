# # s3.tf
# # S3 bucket for storing config files and other artifacts

# # Generate a random suffix for bucket name to ensure uniqueness
# resource "random_id" "bucket_suffix" {
#   byte_length = 4
# }

# # Data source to get current AWS account ID
# data "aws_caller_identity" "current" {}

# # Data source to get current AWS region
# data "aws_region" "current" {}

# # S3 bucket for config storage
# resource "aws_s3_bucket" "config_bucket" {
#   bucket = "app-config-${random_id.bucket_suffix.hex}"

#   tags = {
#     Purpose     = "config-storage"
#     Terraform   = "true"
#   }
# }

# # S3 bucket versioning
# resource "aws_s3_bucket_versioning" "config_bucket_versioning" {
#   bucket = aws_s3_bucket.config_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # S3 bucket server-side encryption configuration
# resource "aws_s3_bucket_server_side_encryption_configuration" "config_bucket_encryption" {
#   bucket = aws_s3_bucket.config_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#     bucket_key_enabled = true
#   }
# }

# # S3 bucket public access block (security best practice)
# resource "aws_s3_bucket_public_access_block" "config_bucket_pab" {
#   bucket = aws_s3_bucket.config_bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # S3 bucket lifecycle configuration
# resource "aws_s3_bucket_lifecycle_configuration" "config_bucket_lifecycle" {
#   bucket = aws_s3_bucket.config_bucket.id

#   rule {
#     id     = "config_lifecycle"
#     status = "Enabled"

#     # Keep non-current versions for 30 days
#     noncurrent_version_expiration {
#       noncurrent_days = 30
#     }

#     # Delete incomplete multipart uploads after 7 days
#     abort_incomplete_multipart_upload {
#       days_after_initiation = 7
#     }
#   }
#}


module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "app-config-${random_id.bucket_suffix.hex}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}




