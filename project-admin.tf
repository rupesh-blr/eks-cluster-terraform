# module "iam_iam-assumable-role-with-oidc" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
#   version = "5.33.0"
# }
module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = var.iam_user_name
  force_destroy = true

  pgp_key = "keybase:test"

  password_reset_required = false
}
# output "user_arn" {
#   value = module.iam_user.iam_user_name.arn
# }
module "eks_auth" {
  source = "aidanmelen/eks-auth/aws"
  eks    = module.eks

  map_roles = [
    {
      rolearn  = "arn:aws:iam::533267265870:role/admin-role"
      username = var.iam_user_name
      groups   = ["system:masters"]
    },
  ]

  map_users = [
    {
      userarn  = module.iam_user.iam_user_name
      username = var.iam_user_name
      groups   = ["system:masters"]
    },
  ]

  map_accounts = [
    "533267265870",
  ]
}
