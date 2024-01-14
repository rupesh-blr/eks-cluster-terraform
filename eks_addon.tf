resource "aws_eks_addon" "eks-addon" {
  count        = length(var.addon_names)
  cluster_name = var.eks_name
  addon_name   = var.addon_names[count.index]
}
