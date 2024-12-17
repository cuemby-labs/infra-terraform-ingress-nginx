#
# Ingress NGINX Variables
#

variable "helm_release_name" {
  description = "The name of the Helm release."
  type        = string
  default     = "ingress-nginx"
}

variable "namespace_name" {
  description = "The namespace where the Helm release will be installed."
  type        = string
  default     = "kube-system"
}

variable "helm_chart_version" {
  description = "The version of the ingress-nginx Helm chart."
  type        = string
  default     = "4.11.3"
}

variable "metrics" {
  description = "Enabled Metrics in the ingress-nginx Helm chart."
  type        = bool
  default     = "true"
}

variable "service_monitor" {
  description = "Enabled Service Monitor in the ingress-nginx Helm chart."
  type        = bool
  default     = "true"
}

variable "resources" {
  type = map(map(string))
  default = {
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
  description = "Resource limits and requests for the Ingress NGINX Helm release."
}

variable "set_custom_values" {
  type = bool
  description = "Set custom values"
  default = false
}

variable "values" {
  description = "Chart values"
  type        = any
  default     = {}
}

variable "hpa_config" {
  description = "Configuration for the HPA targeting Prometheus Deployment"
  type        = object({
    min_replicas              = number
    max_replicas              = number
    target_cpu_utilization    = number
    target_memory_utilization = number
  })

  default = {
    min_replicas              = 1
    max_replicas              = 3
    target_cpu_utilization    = 80
    target_memory_utilization = 80
  }
}

#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}