controller:
  metrics:
    enabled: ${metrics}
    service:
      enabled: ${metrics}
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "10254"
  podAnnotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "10254"
  serviceMonitor:
    enabled: ${service_monitor}
    additionalLabels:
          release: prometheus
  allowSnippetAnnotations: true
  config:
    use-forwarded-headers: "true"
    allowSnippetAnnotations: "true"
  resources:
    limits:
      cpu: ${limits_cpu}
      memory: ${limits_memory}
    requests:
      cpu: ${request_cpu}
      memory: ${request_memory}