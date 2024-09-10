resource "helm_release" "ingress_nginx" {
  name       = var.release_name
  namespace  = var.namespace

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.version

  values     = [file("${path.module}/values.yaml")]
}
locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}