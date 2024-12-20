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
      metrics         = var.metrics,
      service_monitor = var.service_monitor,
      request_memory  = var.resources["requests"]["memory"],
      limits_memory   = var.resources["limits"]["memory"],
      request_cpu     = var.resources["requests"]["cpu"],
      limits_cpu      = var.resources["limits"]["cpu"]
    }),
    yamlencode(var.values)
  ]
}

#
# Service Monitor
#

data "template_file" "service_monitor_template" {  
  template = file("${path.module}/service_monitor.yaml.tpl")
  vars     = {
    namespace_name = var.namespace_name
  }
}

data "kubectl_file_documents" "service_monitor_file" {
  content = data.template_file.service_monitor_template.rendered
}

resource "kubectl_manifest" "apply_service_monitor" {
  for_each  = data.kubectl_file_documents.service_monitor_file.manifests
  yaml_body = each.value

  lifecycle {
    ignore_changes = [yaml_body]
  }

  depends_on = [data.kubectl_file_documents.service_monitor_file]
}

#
# HPA
#

data "template_file" "hpa_manifest_template" {  
  template = file("${path.module}/hpa.yaml.tpl")
  vars     = {
    namespace_name            = var.namespace_name,
    controller_name           = "${var.helm_release_name}-controller",
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

  lifecycle {
    ignore_changes = [yaml_body]
  }

  depends_on = [data.kubectl_file_documents.hpa_manifest_files]
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