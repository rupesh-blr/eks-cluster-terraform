# module "nginx-pod" {
#   rource    = "./modules/kubernetes_pod"
# }

resource "kubernetes_namespace" "data-pg" {
    count = length(var.namespace_names)
  metadata {
    name = var.namespace_names[count.index]
    labels = {
      name = var.namespace_names[count.index]
    }
    annotations = {
      name = "data-annotations"
    }
  }
}
resource "kubernetes_pod" "nginx" {
  metadata {
    name      = "${var.nginx_pod_name}"
    namespace = "${var.namespace_names[0]}"
    labels = {
      app = "nginx"
    }
  }
  spec {
    container {
      name  = "${var.nginx_pod_name}"
      image = "${var.nginx_pod_image}"
    }
  }
}
resource "kubernetes_service" "nginx" {
  metadata {
    name      = "${var.nginx_pod_name}"
    namespace = "${var.namespace_names[0]}"
  }
  spec {
    selector = {
      app = "${kubernetes_pod.nginx.metadata.0.labels.app}"
    }
    port {
      port = 8080
      target_port = 80
    }
    type = "LoadBalancer"
  }
}