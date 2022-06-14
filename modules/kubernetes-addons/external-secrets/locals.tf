locals {
  name = "external-secrets"
  service_account_name = "external-secrets"

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

  set_values = [
    {
      name  = "serviceAccount.name"
      value = local.service_account_name
    },
    {
      name  = "serviceAccount.create"
      value = false
    }
  ]

  irsa_config = {
    kubernetes_namespace              = local.helm_config["namespace"]
    kubernetes_service_account        = local.service_account_name
    create_kubernetes_namespace       = false
    create_kubernetes_service_account = true
    irsa_iam_policies                 = var.irsa_policies
  }

  argocd_gitops_config = {
    enable             = true
    serviceAccountName = local.service_account_name
  }
}
