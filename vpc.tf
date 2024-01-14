
data "aws_availability_zones" "available" {

}

module "eks-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = var.vpc_cidr_block
  map_public_ip_on_launch = true
  azs = data.aws_availability_zones.available.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true 

  private_subnets = var.private_subnet_cidr_block
  public_subnets  = var.public_subnet_cidr_block

  tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
  }
  public_subnet_tags = {
  "kubernetes.io/cluster/eks-cluster" = "shared"
  "kubernetes.io/role/elb"                  = "1"
 }
 private_subnet_tags = {
  "kubernetes.io/cluster/eks-cluster" = "shared"
  "kubernetes.io/role/elb"                  = "1"
}
}