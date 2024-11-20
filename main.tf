#
# Ingress NGINX Resources
#

resource "helm_release" "ingress_nginx" {
  name       = var.helm_release_name
  namespace  = var.namespace_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.helm_chart_version
  values     = [file("${path.module}/values.yaml")]
}

#
# Walrus Information
#

locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}