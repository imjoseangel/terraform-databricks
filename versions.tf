terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.7.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.2.3"
    }
  }
  required_version = ">= 1.0"
}

provider "databricks" {
  host     = format("https://%s.cloud.databricks.com", var.name)
  username = data.external.env.result.DATABRICKS_USERNAME
  password = data.external.env.result.DATABRICKS_PASSWORD
}
