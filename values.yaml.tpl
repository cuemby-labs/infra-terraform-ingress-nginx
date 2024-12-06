controller:
  metrics:
    service:
      externalTrafficPolicy: local
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "10254"
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