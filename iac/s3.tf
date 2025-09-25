# s3.tf
# S3 bucket for storing config files and other artifacts

# Generate a random suffix for bucket name to ensure uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Data source to get current AWS account ID
data "aws_caller_identity" "current" {}

# Data source to get current AWS region
data "aws_region" "current" {}

# S3 bucket for config storage
resource "aws_s3_bucket" "config_bucket" {
  bucket = "${var.project_name}-config-${var.environment}-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-config-${var.environment}"
    Environment = var.environment
    Purpose     = "config-storage"
    Project     = var.project_name
    Terraform   = "true"
  }
}

# S3 bucket versioning
resource "aws_s3_bucket_versioning" "config_bucket_versioning" {
  bucket = aws_s3_bucket.config_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "config_bucket_encryption" {
  bucket = aws_s3_bucket.config_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# S3 bucket public access block (security best practice)
resource "aws_s3_bucket_public_access_block" "config_bucket_pab" {
  bucket = aws_s3_bucket.config_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "config_bucket_lifecycle" {
  bucket = aws_s3_bucket.config_bucket.id

  rule {
    id     = "config_lifecycle"
    status = "Enabled"

    # Keep non-current versions for 30 days
    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    # Delete incomplete multipart uploads after 7 days
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# IAM policy for config bucket access
resource "aws_iam_policy" "config_bucket_policy" {
  name        = "${var.project_name}-config-bucket-policy-${var.environment}"
  description = "Policy for accessing config S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.config_bucket.arn,
          "${aws_s3_bucket.config_bucket.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-config-bucket-policy-${var.environment}"
    Environment = var.environment
    Purpose     = "config-bucket-access"
    Project     = var.project_name
    Terraform   = "true"
  }
}



