module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  environment        = var.environment
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "../../modules/ecr"

  environment = var.environment
}

module "eks_iam" {
  source = "../../modules/eks-iam"

  environment = var.environment
}

module "eks" {
  source = "../../modules/eks"

  environment        = var.environment
  cluster_role_arn   = module.eks_iam.eks_cluster_role_arn
  node_role_arn      = module.eks_iam.eks_node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  kubernetes_version = "1.33"
}
