locals {
  name = "external-secrets"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://charts.external-secrets.io"
    version     = "0.5.6"
    namespace   = local.name
    description = "A Helm chart to install the External Secrets operator"
    values      = []
    timeout     = "1200"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
