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