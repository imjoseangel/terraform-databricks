terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "databricks" {
}
