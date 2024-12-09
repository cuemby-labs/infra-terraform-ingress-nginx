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

variable "values" {
  description = "Chart values"
  type        = any
  default     = {}
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