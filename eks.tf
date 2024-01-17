resource "aws_iam_role" "EKS_role" {
  name = "${var.eks_name}_EKS"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_name
  cluster_version = "1.27"

  subnet_ids      = module.eks-vpc.private_subnets
  vpc_id          = module.eks-vpc.vpc_id

  tags = {
    environment = "development"
    application = "eks-app"
  }
    eks_managed_node_groups = {
        dev1 = {
            node_group_name = "${var.eks-nodegroup}_1"
            min_size        = 1
            max_size        = 3
            desired_size    = 2
            instance_types  = ["t2.large"]
            
        }
        dev2 = {
            node_group_name = "${var.eks-nodegroup}_2"
            min_size        = 1
            max_size        = 3
            desired_size    = 2
            instance_types  = ["t2.large"]
        }
    }
  }
resource "aws_iam_role_policy_attachment" "additional" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::533267265870:policy/ebs-permission"
  role       = each.value.iam_role_name
}
resource "aws_iam_role_policy_attachment" "additional-efs" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = each.value.iam_role_name
}

resource "aws_iam_role_policy_attachment" "additional-ebs" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = each.value.iam_role_name
}

resource "aws_iam_role_policy_attachment" "additional-efs-eks-role" {

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.EKS_role.name
}

resource "aws_iam_role_policy_attachment" "additional-eks-role" {

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.EKS_role.name
}