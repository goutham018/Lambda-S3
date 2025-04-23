# modules/lambda_function/outputs.tf
output "arn" {
  value = aws_lambda_function.this.arn
}
# modules/lambda_function/outputs.tf
output "function_name" {
  value = aws_lambda_function.this.function_name
}

