resource "aws_security_group" "rds-sg" {
  name        = var.rds_sg_name
  description = var.description_rds_sg
  vpc_id      = var.aws_vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules_rds
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  ingress {
    from_port = "5432"
    to_port   = "5432"
    protocol  = "tcp"
    security_groups = [
      "${var.ecs_sg_id}",
    ]
    description = var.rds_sg_ec2_ingress_description
  }

  ingress {
    from_port = "5432"
    to_port   = "5432"
    protocol  = "tcp"
    security_groups = [
      "${var.ec2_sg_id}",
    ]
    description = var.rds_sg_ec2_ingress_description
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = var.rds_sg_name
  })
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.aws_rds_db_subnet_group_name
  subnet_ids = var.aws_rds_subnet_ids
  tags = merge(var.common_tags, {
    Name = var.aws_rds_db_subnet_group_name
  })
}

resource "aws_rds_cluster" "rds-aurora-postgresql" {
  cluster_identifier       = var.rds-cluster-identifier
  engine                   = var.aws_rds_egine
  engine_mode              = var.rds-engine-mode
  availability_zones       = var.rds_azs_list
  engine_version           = var.rds_engine_version_postgres
  database_name            = var.rds_db_name
  master_username          = var.aws_rds_master_username
  master_password          = var.aws_rds_master_password
  backup_retention_period  = var.aws_rds_backup_retention_period
  preferred_backup_window  = var.aws_rds_preferred_backup_window
  db_subnet_group_name     = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids   = [aws_security_group.rds-sg.id]
  delete_automated_backups = var.aws_rds_delete_automated_backups
  deletion_protection      = var.aws_rds_deletion_protection
  skip_final_snapshot      = var.aws_rds_skip_final_snapshot
  storage_encrypted        = var.aws_rds_storage_encrypted
  port                     = var.aws_rds_postgres_port
  apply_immediately        = var.aws_rds_any_changes_apply_immediately
  tags                     = var.aws_rds_tags
}

resource "aws_rds_cluster_instance" "rds-aurora-postgresql-instance" {
  cluster_identifier           = aws_rds_cluster.rds-aurora-postgresql.id
  count                        = var.aurora_instance_count
  identifier                   = "${var.rds-cluster-identifier}-${count.index}"
  instance_class               = var.rds-instance-class
  engine                       = aws_rds_cluster.rds-aurora-postgresql.engine
  engine_version               = aws_rds_cluster.rds-aurora-postgresql.engine_version
  ca_cert_identifier           = var.rds_ca_cert_identifier
  performance_insights_enabled = var.performance_insights_enabled
  publicly_accessible          = var.rds_aurora_publicly_accessible
  tags                         = var.aws_rds_instance_tags

}





