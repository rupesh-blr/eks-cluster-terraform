resource "kubernetes_horizontal_pod_autoscaler" "nginx" {
  metadata {
    name = "terraform-hpa"
  }

  spec {
    max_replicas = 10
    min_replicas = 8

    scale_target_ref {
      kind = "Deployment"
      name = "nginx"
    }
  }
}