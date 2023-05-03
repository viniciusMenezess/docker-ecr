terraform {
  backend "s3" {
    bucket = "terraform-state-viniciusm"
    key = "homolog/terraform.tfstate"
    region = "us-east-1"
  }
}