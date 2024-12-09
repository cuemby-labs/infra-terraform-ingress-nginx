#
# Ingress NGINX Resources
#

resource "helm_release" "ingress_nginx" {
  name       = var.helm_release_name
  namespace  = var.namespace_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.helm_chart_version

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      request_memory = var.resources["requests"]["memory"],
      limits_memory  = var.resources["limits"]["memory"],
      request_cpu    = var.resources["requests"]["cpu"],
      limits_cpu     = var.resources["limits"]["cpu"]
    }),
    yamlencode(var.values)
  ]
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