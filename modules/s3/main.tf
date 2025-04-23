resource "aws_s3_bucket" "src" {
  bucket = var.src-bucket_name
}

variable "src-bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

resource "aws_s3_bucket" "dest" {
  bucket = var.dest_bucket_name
}

variable "dest_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
