resource "aws_eks_cluster" "this" {
  name     = "ecommerce-${var.environment}-eks"
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = {
    Name        = "ecommerce-${var.environment}-eks"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "ecommerce-${var.environment}-nodes"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }

  capacity_type = "ON_DEMAND"

  tags = {
    Name        = "ecommerce-${var.environment}-node"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}
