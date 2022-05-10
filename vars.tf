variable "database_endpoint" {
  type        = string
  description = "database endpoint"
}

variable "db_master_password" {
  type        = string 
  description = "database master password"
}

variable "name" {
  type        = string 
  description = "Name of password"
  default = "nessus"
}

variable "region" {
  type        = string 
  description = "AWS region"
  default = "us-west-1"
}

