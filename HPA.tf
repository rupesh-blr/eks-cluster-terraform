resource "kubernetes_horizontal_pod_autoscaler" "nginx" {
  metadata {
    name = "terraform-hpa"
    namespace = var.namespace_names[1]
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
