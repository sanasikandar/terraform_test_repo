variable "region" { type = string }
variable "key_name" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
