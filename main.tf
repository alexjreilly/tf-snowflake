terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.22.0"
    }
  }
}

provider "snowflake" {
  role     = "SYSADMIN"
  username = "tf-snow"
  account  = "NB57995"
  region   = "EUROPE-WEST2.GCP"

  // optional, at exactly one must be set
  private_key_path = "./tf-snow_private_key"
}

resource "snowflake_database" "my_db" {
  name = "${var.resource_prefix}_my_db"
}

resource "snowflake_warehouse" "my_warehouse1" {
  name           = "${var.resource_prefix}_my_wwarehouse1"
  warehouse_size = "xsmall"

  auto_suspend = 60
}

resource "snowflake_warehouse" "my_warehouse2" {
  name           = "${var.resource_prefix}_my_warehouse2"
  warehouse_size = "xsmall"

  auto_suspend = 60
}
