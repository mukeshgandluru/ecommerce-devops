resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "ecommerce-${var.environment}-vpc"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "ecommerce-${var.environment}-igw"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "ecommerce-${var.environment}-public-rt"
    Environment = var.environment
    Project     = "ecommerce-devops"
    Type        = "public"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "ecommerce-${var.environment}-nat-eip"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.this]

  tags = {
    Name        = "ecommerce-${var.environment}-nat"
    Environment = var.environment
    Project     = "ecommerce-devops"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name        = "ecommerce-${var.environment}-private-rt"
    Environment = var.environment
    Project     = "ecommerce-devops"
    Type        = "private"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "ecommerce-${var.environment}-public-${count.index + 1}"
    Environment = var.environment
    Project     = "ecommerce-devops"
    Type        = "public"
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.${count.index + 11}.0/24"
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "ecommerce-${var.environment}-private-${count.index + 1}"
    Environment = var.environment
    Project     = "ecommerce-devops"
    Type        = "private"
  }
}
