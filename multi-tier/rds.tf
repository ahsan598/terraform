resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private_subnet[*].id

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "app_db" {
  identifier         = "app-db"
  engine             = "mysql"
  instance_class     = "db.t2.micro"
  allocated_storage  = 20
  username               = "admin"
  password               = "password"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot    = true

  tags = {
    Name = "app-db-instance"
  }
}