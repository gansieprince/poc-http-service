resource "random_password" "http_postgres_password" {
  length           = 16
  special          = false
  override_special = "/_%@,"
}

  resource "aws_ssm_parameter" "http_postgres_password" {
  name  = "${local.name}-http-postgres-password"
  type  = "SecureString"
  value = random_password.http_postgres_password.result
  #overwrite = true

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
  }  

  resource "aws_rds_cluster" "http_cluster" {
  cluster_identifier     = "${local.name}-http-cluster"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  database_name          = var.env == "dev" ? "http${var.env}db" : "http${var.env}db"
  master_username        = var.env == "dev" ? "${var.env}${var.product}USR" : "${var.env}${var.product}USR"
  master_password        = random_password.http_postgres_password.result
  db_subnet_group_name   = aws_db_subnet_group.http_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.http_rds_sg.id]
  skip_final_snapshot    = true
}

  resource "aws_rds_cluster_instance" "http_postgres_instance" {
  count              = 2
  identifier         = "${local.name}-http-postgres-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.http_cluster.id
  instance_class     = var.rds_instance_class
  engine             = var.rds_engine
  engine_version     = var.rds_engine_version

  lifecycle {
    ignore_changes = [engine_version  ]
  }
}




resource "aws_db_subnet_group" "http_db_subnet_group" {
  name       = "${local.name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}