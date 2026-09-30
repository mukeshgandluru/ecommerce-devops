variable "repositories" {
  description = "List of ECR repositories"
  type        = list(string)

  default = [
    "ecommerce-user-service",
    "ecommerce-product-service",
    "ecommerce-order-service"
  ]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
