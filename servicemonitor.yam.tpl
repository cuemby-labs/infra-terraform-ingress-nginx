apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: ingress-nginx-controller
  namespace: ${namespace_name}
  labels:
    release: prometheus
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: ingress-nginx
      app.kubernetes.io/component: controller
  endpoints:
    - port: metrics
      interval: 30s
      path: /metrics