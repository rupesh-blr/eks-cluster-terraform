
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

# resource "aws_internet_gateway" "gw" { 
#  vpc_id = module.eks-vpc.vpc_id
 
#  tags = {
#    Name = "Project VPC IG"
#  }
# }

# resource "aws_route_table" "second_rt" {
#  vpc_id = module.eks-vpc.vpc_id
 
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.gw.id
#  }
 
#  tags = {
#    Name = "2nd Route Table"
#  }
# }

# resource "aws_route_table_association" "public_subnet_asso" {
#  count = length(var.public_subnet_cidr_block)
#  subnet_id      = module.eks-vpc.public_subnets[count.index].id
#  route_table_id = aws_route_table.second_rt.id
# }