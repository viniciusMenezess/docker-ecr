resource "aws_ecr_repository" "ecrRepository" {
  name = var.repositoryName
}