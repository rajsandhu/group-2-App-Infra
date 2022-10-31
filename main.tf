resource "aws_s3_bucket" "group2_backend_bucket" {
  bucket = "group-2-elk-4073724601872"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "group-2-elk-4073724601872"
    Environment = "Test"
    Team        = "Group-2-ELK"
    Owner       = "Isabelle"
  }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.group2_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock"
  }
}