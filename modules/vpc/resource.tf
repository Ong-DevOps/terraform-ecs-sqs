resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = var.aws_enable_dns_hostnames
  tags = merge(var.common_tags, {
    Name = var.aws_vpc_name
  })
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = var.no-of-private-subnet != null ? var.no-of-private-subnet : length(data.aws_availability_zones.available_az.names)
  availability_zone = data.aws_availability_zones.available_az.names[count.index % length(data.aws_availability_zones.available_az.names)]
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, var.aws_private_subnet_cidr_newbits, length(data.aws_availability_zones.available_az.names) + count.index)
  tags = merge(var.common_tags, {
    Name = "${var.aws_private_subnet_name}-${count.index}"
  })
  lifecycle {
    ignore_changes = [availability_zone]
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.no-of-public-subnet != null ? var.no-of-public-subnet : length(data.aws_availability_zones.available_az.names)
  availability_zone       = data.aws_availability_zones.available_az.names[count.index % length(data.aws_availability_zones.available_az.names)]
  cidr_block              = cidrsubnet(var.aws_vpc_cidr, var.aws_public_subnet_cidr_newbits, count.index)
  map_public_ip_on_launch = "true"
  tags = merge(var.common_tags, {
    Name = "${var.aws_public_subnet_name}-${count.index}"
  })
  lifecycle {
    ignore_changes = [availability_zone]
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  count  = var.no-of-public-subnet != 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.common_tags, {
    Name = var.aws_internet_gateway_name
  })
}

resource "aws_route_table" "public-subnets-rt" {
  count  = var.no-of-public-subnet != 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.aws_vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw[0].id
  }
  tags = merge(var.common_tags, {
    Name = var.aws_public_rt_name
  })
}

resource "aws_route_table" "private-subnets-rt" {
  count  = var.no-of-private-subnet != 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.aws_vpc_cidr
    gateway_id = "local"
  }

  tags = merge(var.common_tags, {
    Name = var.aws_private_rt_name
  })
}


resource "aws_route_table_association" "aws_private_rt_association" {
  count          = var.no-of-private-subnet != null ? var.no-of-private-subnet : length(data.aws_availability_zones.available_az.names)
  route_table_id = aws_route_table.private-subnets-rt[0].id
  subnet_id      = aws_subnet.private-subnet[count.index].id
}

resource "aws_route_table_association" "aws_public_rt_association" {
  count          = var.no-of-public-subnet != null ? var.no-of-public-subnet : length(data.aws_availability_zones.available_az.names)
  route_table_id = aws_route_table.public-subnets-rt[0].id
  subnet_id      = aws_subnet.public-subnet[count.index].id
}


resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id              = aws_vpc.vpc.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = aws_subnet.public-subnet.*.id
  tags = merge(var.common_tags, {
    Name = var.vpc_ecr_endpoint_name_dkr
    }
  )
}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = aws_subnet.public-subnet.*.id
  tags = merge(var.common_tags, {
    Name = var.vpc_ecr_endpoint_name_api
    }
  )
}


resource "aws_security_group" "vpc_endpoint_sg" {
  name   = var.vpc_endpoint_sg_name
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = "443"
    to_port   = "443"
    protocol  = "tcp"
    security_groups = [
      "${var.ecs_sg_id}",
    ]
    description = var.vpc_endpoint_sg_description
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = var.vpc_endpoint_sg_name
  })
}