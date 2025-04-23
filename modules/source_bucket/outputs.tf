# modules/s3_bucket/outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
output "arn" {
  value = aws_s3_bucket.this.arn
}
