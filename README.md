# Ingress-NGINX Template

Terraform module which deploys Ingress NGINX on any kubernetes cluster.

## Usage

```hcl
module "ingress_nginx" {
  source              = "./modules/ingress_nginx" # Path to the Ingress NGINX module

  helm_release_name   = "ingress-nginx"           # The name of the Helm release.
  namespace_name      = "kube-system"             # The namespace where Ingress NGINX will be installed.
  helm_chart_version  = "4.11.3"                  # The version of the Ingress NGINX Helm chart to be used.
  metrics             = "true"                    # Enable metrics in the Ingress NGINX Helm chart to be used.
  service_monitor     = "true"                    # Enable Service Monitor in the Ingress NGINX Helm chart to be used.

  resources = {
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}
```

## Examples

- ...
- ...

## Contributing

Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | >= 1.5.7 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.example](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace_name"></a> [namespace_name](#input_namespace_name) | Namespace where Ingress NGINX will be installed. | string | "kube-system" | no |
| <a name="input_helm_release_name"></a> [helm_release_name](#input_helm_release_name) | Name for the Ingress NGINX Helm release. | string | "ingress-nginx" | no |
| <a name="input_helm_chart_version"></a> [helm_chart_version](#input_helm_chart_version) | Version of the Ingress NGINX Helm chart. | string | "4.11.3" | no |
| <a name="input_metrics"></a> [metrics](#input_metrics) | Enabled Metrics in the ingress-nginx Helm chart. | bool | "yes" | no |
| <a name="input_service_monitor"></a> [service_monitor](#input_service_monitor) | Enabled service monitor in the ingress-nginx Helm chart. | bool | "yes" | no |
| <a name="input_resources"></a> [resources](#input_resources) | Resource limits and requests for the helm chart pods. | `map(object(string))` | `"See example"` | no |
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br><br>Examples:<pre>context:<br>  project:<br>    name: string<br>    id: string<br>  environment:<br>    name: string<br>    id: string<br>  resource:<br>    name: string<br>    id: string</pre> | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_walrus_environment_id"></a> [walrus\_environment\_id](#output\_walrus\_environment\_id) | The id of environment where deployed in Walrus. |
| <a name="output_walrus_environment_name"></a> [walrus\_environment\_name](#output\_walrus\_environment\_name) | The name of environment where deployed in Walrus. |
| <a name="output_walrus_project_id"></a> [walrus\_project\_id](#output\_walrus\_project\_id) | The id of project where deployed in Walrus. |
| <a name="output_walrus_project_name"></a> [walrus\_project\_name](#output\_walrus\_project\_name) | The name of project where deployed in Walrus. |
| <a name="output_walrus_resource_id"></a> [walrus\_resource\_id](#output\_walrus\_resource\_id) | The id of resource where deployed in Walrus. |
| <a name="output_walrus_resource_name"></a> [walrus\_resource\_name](#output\_walrus\_resource\_name) | The name of resource where deployed in Walrus. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
