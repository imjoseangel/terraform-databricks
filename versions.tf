terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "1.2.0"
    }
  }
}

provider "databricks" {
  host     = format("https://%s.cloud.databricks.com", var.name)
  username = data.external.env.result.DATABRICKS_USERNAME
  password = data.external.env.result.DATABRICKS_PASSWORD
}
