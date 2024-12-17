#
# Ingress NGINX Resources
#

resource "helm_release" "ingress_nginx" {
  name       = var.helm_release_name
  namespace  = var.namespace_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.helm_chart_version

  values = var.set_custom_values ? [yamlencode(var.values)] : []

  set {
    name  = "controller.resources.requests.cpu"
    value = var.resources["requests"]["cpu"]
  }
  set {
    name  = "controller.resources.requests.memory"
    value = var.resources["requests"]["memory"]
  }
  set {
    name  = "controller.resources.limits.cpu"
    value = var.resources["limits"]["cpu"]
  }
  set {
    name  = "controller.resources.limits.memory"
    value = var.resources["limits"]["memory"]
  }
}

#
# Service Monitor
#

resource "kubernetes_manifest" "service_monitor_ingress_nginx" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata" = {
      "name"      = "ingress-nginx-controller"
      "namespace" = var.namespace_name
      "labels" = {
        "release" = "prometheus"
      }
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name"       = "ingress-nginx"
          "app.kubernetes.io/component"  = "controller"
        }
      }
      "endpoints" = [
        {
          "port"     = "metrics"
          "interval" = "30s"
          "path"     = "/metrics"
        }
      ]
    }
  }
}

#
# HPA
#

data "template_file" "hpa_manifest_template" {
  
  template = file("${path.module}/hpa.yaml.tpl")
  vars     = {
    namespace_name            = var.namespace_name,
    controller_name           = "${helm_release.ingress_nginx.name}-controller",
    min_replicas              = var.hpa_config.min_replicas,
    max_replicas              = var.hpa_config.max_replicas,
    target_cpu_utilization    = var.hpa_config.target_cpu_utilization,
    target_memory_utilization = var.hpa_config.target_memory_utilization
  }
}

data "kubectl_file_documents" "hpa_manifest_files" {

  content = data.template_file.hpa_manifest_template.rendered
}

resource "kubectl_manifest" "apply_hpa_manifests" {
  for_each  = data.kubectl_file_documents.hpa_manifest_files.manifests
  yaml_body = each.value
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