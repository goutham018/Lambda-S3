# modules/s3_bucket/outputs.tf
output "src_bucket_name" {
  value = aws_s3_bucket.src.bucket
}


# modules/s3_bucket/outputs.tf
output "dest_bucket_name" {
  value = aws_s3_bucket.dest.bucket
}
output "arn" {
  value = aws_s3_bucket.src.arn
}
