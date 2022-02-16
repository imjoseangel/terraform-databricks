terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.4.9"
    }
  }
  required_version = ">= 1.0"
}

provider "databricks" {
}
