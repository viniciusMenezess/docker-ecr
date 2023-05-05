module "prod" {
  source = "../../infra"

  repositoryName = "producao"
  iamPosition = "producao"
}

output "ipLoadBalancerOutput" {
  value = module.prod.loadBalancerOutput
}