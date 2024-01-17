resource "helm_release" "mongodb" {
  name       = "mongodb"

  repository = "https://github.com/rupesh-blr/eks-cluster-terraform/tree/MongoDB/mongodb"
  chart      = "mongodb"
  namespace  = "${var.namespace_names}"
}

# resource "helm_release" "metrics-server" {
#   name       = "metrics-server"

#   repository = "https://github.com/rupesh-blr/eks-cluster-terraform.git"
#   chart      = "metrics-server"
#   namespace  = "${var.namespace_names[1]}"
# }

# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress-controller"

#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "nginx-ingress-controller"

#   set {
#     name  = "service.type"
#     value = "ClusterIP"
#   }
# }