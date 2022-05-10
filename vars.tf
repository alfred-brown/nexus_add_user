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
  default = "nexus"
}

variable "region" {
  type        = string 
  description = "AWS region"
  default = "us-west-1"
}

variable "db_identifier" {
  type        = string
  description = "The AWS identifier"

}
