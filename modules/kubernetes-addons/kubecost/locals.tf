locals {
  namespace = "kubecost"
  service_account_name = "kubecost-cost-analyzer"

  irsa_config = {
    kubernetes_namespace              = local.namespace
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
