# Required for the s3 bucket
terraform {
    backend  "s3" {
    region         = "us-west-2"
    bucket         = "cit480groupbuck"
    key            = "remote1" 
    dynamodb_table = "tf-state-lock"
    }
} 

resource "aws_s3_bucket" "tf-remote-state" {
  bucket = "cit480groupbuck"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name            = "tf-state-lock" 
  hash_key        = "LockID"
  read_capacity   = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
} 
