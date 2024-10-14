#
# Ingress NGINX Resources
#

resource "helm_release" "ingress_nginx" {
  name       = var.release_name
  namespace  = var.namespace_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version
  values     = [file("${path.module}/values.yaml")]
}

#
# Walrus Information
#

locals {
  context = var.context
}