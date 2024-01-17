resource "kubernetes_namespace" "data-pg" {
  metadata {
    name = var.namespace_names
    labels = {
      name = var.namespace_names
    }
    annotations = {
      name = "data-annotations"
    }
  }
}

# resource "kubernetes_namespace" "example" {
#   metadata {
#     annotations = {
#       name = "example-annotation"
#     }

#     labels = {
#       mylabel = "label-value"
#     }

#     name = "terraform-example-namespace"
#   }
# }