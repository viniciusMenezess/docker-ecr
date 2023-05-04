module "prod" {
  source = "../../infra"

  repositoryName = "producao"
  iamPosition = "producao"
}