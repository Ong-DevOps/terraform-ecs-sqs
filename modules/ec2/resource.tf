resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  vpc_id      = var.aws_vpc_id
  description = var.ec2_sg_name
  dynamic "ingress" {
    for_each = var.ingress_rules_ec2
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, {
    Name = var.ec2_sg_name
  })
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = var.aws_ec2_key_pair_name
  public_key = var.ec2_public_key
  tags = merge(var.common_tags, {
    Name = var.aws_ec2_key_pair_name
  })

}

resource "aws_instance" "terraform-instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_type
  key_name                    = aws_key_pair.ec2-key-pair.key_name
  subnet_id                   = element(var.aws_public_subents, 0)
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  user_data                   = base64encode(var.aws_ec2_user_data)
  iam_instance_profile        = var.aws_iam_role_for_ec2
  tags = merge(var.common_tags, {
    Name = var.ec2_name
  })
}


