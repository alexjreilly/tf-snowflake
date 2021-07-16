variable "landing_db_name" {
  type = string
}

variable "landing_schema" {
  type = string
}

variable "landing_tables" {
  type = map(map(string))
}
