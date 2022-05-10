terraform {
  required_providers { 
      aws = { 
          source = "hashicorp/aws"
          version = "3.53.0"
      }
      postgresql = { 
          source = "cyrilgdn/postgresql"
          version = "1.16.0"
      }
  }
}

provider "aws" {
  region = var.region
} 

provider "postgresql" {
  scheme   = "awspostgres"
  host     = var.database_endpoint
  username = "postgres"
  port     = 5432
  password = var.db_master_password
  connect_timeout = 15

  superuser = false
}
