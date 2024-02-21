module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.2.1"

  cluster_name    = "eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.public_subnets
  control_plane_subnet_ids       = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      Name           = "node_group_1"
      min_size       = 1
      max_size       = 2
      desired_size   = 2
      instance_types = ["t3.small"]
    }
    two = {
      Name           = "node_group_2"
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = ["t3.small"]

    }
  }
}
