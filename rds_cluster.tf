resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [
    aws_subnet.dados_a.id,
    aws_subnet.dados_b.id,
  aws_subnet.dados_c.id, ]

  tags = {
    Name = "db-subnet-group"
  }

}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier   = "aurora-cluster"
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.12.0"
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  database_name        = "ada_db"
  master_username      = "root"
  master_password      = "root_password"
}
