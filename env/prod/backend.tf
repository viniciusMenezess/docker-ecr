terraform {
  backend "s3" {
    bucket = "terraform-state-viniciusm"
    key = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}