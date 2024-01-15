# data "aws_caller_identity" "current" {}

# resource "aws_iam_policy" "policy" {
#   for_each    = local.entity
#   name        = "${each.key}"
#   path        = "/"
#   description = "IAM policy to access EKS cluster as ${each.key}"

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#          {
#             "Effect": "Allow",
#             "Action": [
#               "eks:DescribeCluster",
#               "eks:ListClusters"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "sts:AssumeRole",
#             "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${each.key}"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_role" "role" {
#   for_each              = local.entity
#   name                  = "${each.key}"
#   path                  = "/"
#   description           = "IAM role to provide access to EKS ${each.key} users"
#   force_detach_policies = false
#   tags                  = var.tags
#   depends_on            = [aws_iam_policy.policy]
#   assume_role_policy    = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
#   for_each   = aws_iam_policy.policy
#   role       = each.value["name"]
#   policy_arn = each.value["arn"]

#   depends_on = [
#     aws_iam_policy.policy,
#     aws_iam_role.role
#   ]
# }

# resource "kubernetes_role" "role" {
#   for_each    = local.entity
#   metadata {
#     name = "${each.key}-user"
#     namespace = var.namespace
#   }
#   rule {
#     api_groups     = "${each.value.rule.api_groups}"
#     resources      = "${each.value.rule.resources}"
#     verbs          = "${each.value.rule.resources}"
#   }
# }

# resource "kubernetes_role_binding" "binding" {
#   for_each    = local.entity
#   metadata {
#     name      = "${each.key}-user"
#     namespace = var.namespace
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = "${each.key}-user"
#   }

#   subject {
#     kind      = "Group"
#     name      = "${each.key}"
#     namespace = var.namespace
#     api_group = "rbac.authorization.k8s.io"
#   }
# }