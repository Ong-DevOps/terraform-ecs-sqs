locals {
  common_tags = {
    "Managed By"  = "Terraform",
    "Environment" = "Production",
    "Used_for"    = "invoice-management"
  }
}


######  EC2  Ingress  ###############################

locals {
  ingress_rules_ec2 = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["122.176.85.69/32"]
      description = "OnGraph Noida L1"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["122.161.48.205/32"]
      description = "Ankur"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["115.246.79.60/32"]
      description = "OnGraph Noida L8"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["49.36.181.56/32"]
      description = "madhusudhan"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["49.43.160.132/32"]
      description = "Ankit"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["115.246.77.250/32"]
      description = "OnGraph Noida L8"
    }
  ]
}

#########  RDS  Ingress  ##############################

locals {
  ingress_rules_rds = [

    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["115.246.79.60/32"]
      description = "OnGraph Noida L8"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["122.176.85.69/32"]
      description = "OnGraph Noida L1"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["115.246.77.250/32"]
      description = "OnGraph Noida L8"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["115.246.79.60/32"]
      description = "OnGraph Noida L8"
    }
  ]
}




######  ECS  Ingress  ###############################

locals {
  ingress_rules_ecs = [

    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["115.246.79.60/32"]
      description = "OnGraph Noida L8"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["122.176.85.69/32"]
      description = "OnGraph Noida L1"
    },
    { ## for testing only
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    }
  ]
}

