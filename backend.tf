terraform {
  backend "s3" {
    bucket = "b16-exlearn-bucket"
    key = "qa/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}