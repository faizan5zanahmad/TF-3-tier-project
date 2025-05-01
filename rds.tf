resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "main-db-instance"
  engine                 = "mysql"
  engine_version         = "8.0" # or your preferred version
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  backup_retention_period = 7
  publicly_accessible    = false
  multi_az               = false

  tags = {
    Name = "main-db-instance"
  }
}
