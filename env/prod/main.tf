module "prod" {
  source = "../../infra"

  repositoryName = "producao"
  iamPosition = "producao"
  environment = "producao"
}

output "ipLoadBalancerOutput" {
  value = module.prod.loadBalancerOutput
}