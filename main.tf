locals {
  random_password = random_password.rand_password.result 
}

# Creating secret

data "aws_db_instance" "database" {
  db_instance_identifier = "test-database"
}

resource "random_password" "rand_password" {
  length = 16 
  special = true
  override_special = "_^%!"
}

resource "aws_secretsmanager_secret" "nessus" {
  name = "${var.name}-db-password" 
}

resource "aws_secretsmanager_secret_version" "nessus" {
  secret_id     = aws_secretsmanager_secret.nessus.id
  secret_string = <<EOF
{
  "username": "${data.aws_db_instance.database.master_username}",
  "password": "${local.random_password}",
  "engine": "postgres",
  "host": "${data.aws_db_instance.database.endpoint}",
  "port": ${data.aws_db_instance.database.port},
  "dbClusterIdentifier": "test-database"
}
EOF

  depends_on = [
    data.aws_db_instance.database
  ]

}


# Adding database user 

data "aws_secretsmanager_secret_version" "nessus" {
  secret_id = aws_secretsmanager_secret.nessus.id
  depends_on = [
    aws_secretsmanager_secret_version.nessus
  ]
}

resource "postgresql_role" "nessus" {
  name     = "nessus"
  login    = true
  password = data.aws_secretsmanager_secret_version.nessus.secret_string

  
}

resource "postgresql_grant_role" "read_all" {
  role = "nessus"
  grant_role = "pg_read_all_settings"
  depends_on = [
    postgresql_role.nessus
  ]
}
