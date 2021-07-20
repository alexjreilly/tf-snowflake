terraform {
  required_version = ">=1.0.0"

  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "~> 0.24.0"
    }
  }
}

provider "snowflake" {
  account = var.SNOWFLAKE_provider_account
  region = var.SNOWFLAKE_provider_region
  username = var.SNOWFLAKE_provider_username
  password = var.SNOWFLAKE_provider_password
  role = "ACCOUNTADMIN"
}

resource "snowflake_database" "landing_db" {
  name    = terraform.workspace == "default" ? "RAW" : "RAW_${terraform.workspace}"
  comment = "Some comment"
}

module "landing_schema1" {
  source = "./modules/landing_schema/"
  landing_db_name = snowflake_database.landing_db.name
  landing_schema = "SCHEMA_1"
  landing_tables = {
    "TABLE_1": {
      "COL1": "VARCHAR(100)",
      "COL2": "VARCHAR(100)"
    }
  }
}

module "landing_schema2" {
  source = "./modules/landing_schema/"
  landing_db_name = snowflake_database.landing_db.name
  landing_schema = "SCHEMA_2"
  landing_tables = {
    "CUSTOMER": {
      "CUSTOMER_KEY": "NUMBER(38,0)",
      "NAME": "VARCHAR(100)",
      "DOB": "TIMESTAMP_NTZ(9)"
    },
    "TRANSACTION": {
      "TRANSACTION_KEY": "NUMBER(38,0)",
      "CUSTOMER_KEY": "NUMBER(38,0)",
      "TRANSACTION_DATETIME": "TIMESTAMP_NTZ(9)"
    }
  }
}
