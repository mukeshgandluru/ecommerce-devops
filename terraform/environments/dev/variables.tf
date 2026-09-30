variable "vpc_cidr" {
  description = "CIDR block for the development VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "availability_zones" {
  description = "Availability zones for the development VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
