controller:
  metrics:
    enable: ${metrics}
    service:
      enable: ${metrics}
      service:
        annotations:
          prometheus.io/scrape: "true"
          prometheus.io/port: "10254"
    serviceMonitor:
      enabled: ${service_monitor}
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