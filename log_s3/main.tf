
locals {
  bucket_name = "s3-log-${var.bucket_name.environment}-${var.bucket_name.region}-${random_uuid.this.result}"
  tags = {
    Name            = local.bucket_name
    Description     = var.tag_Description
    Environment     = var.tag_Environment
    Project         = var.tag_Project
    Owner           = var.tag_Owner
    BusinessUnit    = var.tag_BusinessUnit
    OpCo            = var.tag_OpCo
    Confidentiality = var.tag_Confidentiality
    ServiceLevel    = var.tag_ServiceLevel
    SecurityOwner   = var.tag_SecurityOwner
    TechnicalOwner  = var.tag_TechnicalOwner
    Source          = var.tag_Source



  }
}
resource "random_uuid" "this" {}



module "s3_bucket" {
  source = "../modules/s3"

  bucket        = local.bucket_name
  acl           = "log-delivery-write"
  force_destroy = true

  attach_policy = true


  attach_deny_insecure_transport_policy = true

  tags = local.tags

  versioning = {
    enabled    = true
    mfa_delete = false
  }

  # logging = {
  #   target_bucket = "maf-bucket-log-123"
  #   target_prefix = "log/"
  # }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {

        sse_algorithm = "AES256"
      }
    }
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
}