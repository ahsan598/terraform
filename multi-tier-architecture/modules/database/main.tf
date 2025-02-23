# RDS Subnet Group
resource "aws_db_subnet_group" "multi_tier_db_subnet_group" {
  name       = "${var.project_name}-multi-tier-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-multi-tier-db-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "multi_tier_db_sg" {
  name        = "${var.project_name}-multi-tier-db-sg"
  description = "Security group for database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-multi-tier-db-sg"
  }
}

# Allow inbound connections from App Servers on DB port
resource "aws_security_group_rule" "db_ingress" {
  security_group_id        = aws_security_group.multi_tier_db_sg.id
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = var.app_sg_id
}

# Allow outbound traffic from DB to anywhere
resource "aws_security_group_rule" "db_egress" {
  security_group_id = aws_security_group.multi_tier_db_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}

# RDS Instance
resource "aws_db_instance" "multi_tier_db_instance" {
  identifier              = "${var.project_name}-multi-tier-db"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_encrypted       = var.db_storage_encrypted
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = var.db_parameter_group
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.multi_tier_db_subnet_group.name
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "${var.project_name}-multi-tier-db"
  }
}