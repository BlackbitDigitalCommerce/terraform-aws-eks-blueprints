#resource "kubernetes_namespace_v1" "argocd_image_updater" {
#  metadata {
#    name = local.namespace
#
#    labels = {
#      "app.kubernetes.io/managed-by" = "terraform-aws-eks-blueprints"
#    }
#  }
#}

module "helm_addon" {
  source            = "../helm-addon"
  manage_via_gitops = var.manage_via_gitops
  set_values        = local.set_values
  helm_config       = local.helm_config
  irsa_config       = local.irsa_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.argocd_image_updater]
}
