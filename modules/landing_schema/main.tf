resource "snowflake_schema" "db_schema" {
  name     = var.landing_schema
  database = var.landing_db_name
}

resource "snowflake_table" "db_schema_table" {
  for_each = var.landing_tables
  name     = each.key
  database = var.landing_db_name
  schema   = snowflake_schema.db_schema.name

  dynamic "column" {
    for_each = each.value
    content {
      name = column.key
      type = column.value
    }
  }
}
