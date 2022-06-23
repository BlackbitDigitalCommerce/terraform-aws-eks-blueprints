locals {
  name = "argocd-image-updater"
  namespace = "argocd"
  service_account_name = "argocd-image-updater"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://argoproj.github.io/argo-helm"
    version     = "0.8.0"
    namespace   = local.namespace
    description = "A Helm chart to install argocd image updater"
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
    eks_cluster_id                    = var.addon_context.eks_cluster_id
    irsa_iam_policies                 = var.irsa_policies
    tags                              = var.addon_context.tags
  }

  argocd_gitops_config = {
    enable             = true
    serviceAccountName = local.service_account_name
  }
}
