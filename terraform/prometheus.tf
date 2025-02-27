# resource "aws_prometheus_workspace" "amp" {
#   alias = "ampEks"

#   tags = {
#     Environment = "development"
#   }
# }

# resource "aws_prometheus_scraper" "scrapper" {
#   source {
#     eks {
#       cluster_arn = aws_eks_cluster.devops-project.arn
#       subnet_ids  = aws_subnet.private.*.id
#     }
#   }

#   destination {
#     amp {
#       workspace_arn = aws_prometheus_workspace.amp.arn
#     }
#   }

#   scrape_configuration = <<EOT
# global:
#   scrape_interval: 30s
# scrape_configs:
#   # pod metrics
#   - job_name: pod_exporter
#     kubernetes_sd_configs:
#       - role: pod
#   # container metrics
#   - job_name: cadvisor
#     scheme: https
#     authorization:
#       credentials_file: /var/run/secrets/kubernetes.io/serviceaccount/token
#     kubernetes_sd_configs:
#       - role: node
#     relabel_configs:
#       - action: labelmap
#         regex: __meta_kubernetes_node_label_(.+)
#       - replacement: kubernetes.default.svc:443
#         target_label: __address__
#       - source_labels: [__meta_kubernetes_node_name]
#         regex: (.+)
#         target_label: __metrics_path__
#         replacement: /api/v1/nodes/$1/proxy/metrics/cadvisor
#   # apiserver metrics
#   - bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
#     job_name: kubernetes-apiservers
#     kubernetes_sd_configs:
#     - role: endpoints
#     relabel_configs:
#     - action: keep
#       regex: default;kubernetes;https
#       source_labels:
#       - __meta_kubernetes_namespace
#       - __meta_kubernetes_service_name
#       - __meta_kubernetes_endpoint_port_name
#     scheme: https
#   # kube proxy metrics
#   - job_name: kube-proxy
#     honor_labels: true
#     kubernetes_sd_configs:
#     - role: pod
#     relabel_configs:
#     - action: keep
#       source_labels:
#       - __meta_kubernetes_namespace
#       - __meta_kubernetes_pod_name
#       separator: '/'
#       regex: 'kube-system/kube-proxy.+'
#     - source_labels:
#       - __address__
#       action: replace
#       target_label: __address__
#       regex: (.+?)(\\:\\d+)?
#       replacement: $1:10249
# EOT
# }
