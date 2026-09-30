output "vpc_id" {
  description = "Development VPC ID"
  value       = module.vpc.vpc_id
}

output "internet_gateway_id" {
  description = "Development Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "public_subnet_ids" {
  description = "Development public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Development private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  description = "Development NAT Gateway ID"
  value       = module.vpc.nat_gateway_id
}

output "nat_eip" {
  description = "Development NAT Gateway Elastic IP"
  value       = module.vpc.nat_eip
}

output "ecr_repository_urls" {
  description = "ECR repository URLs"
  value       = module.ecr.repository_urls
}

output "eks_cluster_role_arn" {
  description = "Development EKS cluster IAM role ARN"
  value       = module.eks_iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  description = "Development EKS worker node IAM role ARN"
  value       = module.eks_iam.eks_node_role_arn
}

output "eks_cluster_name" {
  description = "Development EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Development EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_node_group_name" {
  description = "Development EKS managed node group name"
  value       = module.eks.node_group_name
}
