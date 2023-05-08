module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name    = "vcc-cci-${var.project_name}-${var.environment}"
  cluster_version = "1.24"

  cluster_endpoint_public_access  = true
  kms_key_owners = [
    "arn:aws:iam::620241740192:user/adminterraform", 
    "arn:aws:iam::620241740192:user/admin"
  ]  

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 4
      desired_size = 1

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
    }
  }

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::620241740192:role/CCI-OIDC-Role"
      username = "cci-oidc-role"
      groups   = ["system:masters"]
    }

  ]

  tags = {
    Terraform = "true"
    Environment = var.environment_name
    Project = var.project_name
  }
}
