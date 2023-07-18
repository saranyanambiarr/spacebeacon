provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "eks-cluster"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "test-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
#value is shared bcoz it's being shared with other services or other EKS clusters
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}