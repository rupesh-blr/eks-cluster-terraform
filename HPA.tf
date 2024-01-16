resource "kubernetes_horizontal_pod_autoscaler" "nginx" {
  metadata {
    name = "terraform-hpa"
    namespace = var.namespace_names[1]
  }

  spec {
    max_replicas = 2
    min_replicas = 1

    scale_target_ref {
      kind = "Deployment"
      name = "nginx"
    }
    target_cpu_utilization_percentage = 50
  }
}


# resource "kubernetes_horizontal_pod_autoscaler_v1" "hpa_myapp3" {
#   metadata {
#     name = "hpa-app3"
#   }
#   spec {
#     max_replicas = 10
#     min_replicas = 1
#     scale_target_ref {
#       api_version = "apps/v1"
#       kind = "Deployment"
#       name = kubernetes_deployment_v1.myapp3.metadata[0].name 
#     }
#     target_cpu_utilization_percentage = 50
#   }
# }