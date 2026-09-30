resource "aws_ecr_repository" "services" {
  for_each = toset(var.repositories)

  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project     = "ecommerce-devops"
    Environment = var.environment
    Service     = each.value
  }
}
