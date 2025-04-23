terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "eu-west-1"
}
module "source_bucket" {
  source      = "./modules/source_bucket"
  bucket_name = "bucket-for-image14"
}

module "destination_bucket" {
  source      = "./modules/destination_bucket"
  bucket_name = "bucket-for-storing14"
}

module "iam" {
  source             = "./modules/iam"
  role_name          = "lambda_exec_role"
  policy_name        = "lambda_policy"
  source_bucket      = module.source_bucket.bucket_name
  destination_bucket = module.destination_bucket.bucket_name
}

module "lambda_function" {
  source               = "./modules/lambda_function"
  function_name        = "image_processor"
  handler              = "index.lambda_handler"
  runtime              = "python3.8"
  role_arn             = module.iam.lambda_exec_role_arn
  filename             = "lambda.zip"
  environment_variables = {
    DEST_BUCKET = module.destination_bucket.bucket_name
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.source_bucket.bucket_name

  lambda_function {
    lambda_function_arn = module.lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3_invocation]
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowS3Invocation"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.source_bucket.arn
}

