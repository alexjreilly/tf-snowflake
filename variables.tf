variable "SNOWFLAKE_USER" {
  type = string
}

variable "SNOWFLAKE_PRIVATE_KEY_PATH" {
  type = string
}

variable "resource_prefix" {
  type    = string
  default = "stg"
}
