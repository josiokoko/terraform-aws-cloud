resource "aws_db_instance" "db_terraform" {
  identifier                 = "joehome-${terraform.workspace}"
  allocated_storage          = 10
  engine                     = "mysql"
  engine_version             = "5.7"
  storage_type               = "gp2"
  instance_class             = "db.t2.micro"
  db_name                    = "db_terraform"
  username                   = "joehome"
  password                   = "Admin1234"
  parameter_group_name       = "default.mysql5.7"
  db_subnet_group_name       = aws_db_subnet_group.db_terraform.id
  backup_window              = "01:00-01:30"
  auto_minor_version_upgrade = false
  skip_final_snapshot        = true
}


resource "aws_db_subnet_group" "db_terraform" {
  name       = "joehome-rds"
  subnet_ids = local.private_subnets_ids

  tags = {
    Name = "Joe RDB subnet group"
  }
}



resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow traffic to and from rds"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
  }

}