module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_name
  cluster_version = "1.27"

  subnet_ids      = module.eks-vpc.public_subnets
  vpc_id          = module.eks-vpc.vpc_id

  tags = {
    environment = "development"
    application = "eks-app"
  }
    eks_managed_node_groups = {
        dev1 = {
            node_group_name = "eks-nodegroup1"
            min_size        = 1
            max_size        = 3
            desired_size    = 2
            instance_types  = ["t2.large"]
            labels = {
            name = var.namespace_names[0]
            }
        }
        dev2 = {
            node_group_name = "eks-nodegroup2"
            min_size        = 1
            max_size        = 3
            desired_size    = 2
            instance_types  = ["t2.large"]
            labels = {
            name = var.namespace_names[1]
            }
        }
    }
  }
