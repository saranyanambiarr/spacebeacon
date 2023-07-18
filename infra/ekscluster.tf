module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"
  subnet_ids      = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id
  create_iam_role = true
  
  eks_managed_node_group_defaults = {
    karpenter = {
        root_volume_type = "gp2"
    }
  }

# EKS Managed Node Group(s)
  eks_managed_node_groups = {

    blue={
        name                          = "worker-group-1"
        instance_type                 = "t2.medium"
        additional_userdata           = "echo node1"
        additional_security_group_ids = [aws_security_group.node1.id]
        asg_desired_capacity          = 2
        
    }

    green={
        name                          = "worker-group-2"
        instance_type                 = "t2.medium"
        additional_userdata           = "echo node2"
        additional_security_group_ids = [aws_security_group.node2.id]
        asg_desired_capacity          = 1
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
  # vpc_config {
  #   cluster_security_group_id = data.aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  # }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
