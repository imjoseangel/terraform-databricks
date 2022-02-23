#-------------------------------
# Data Source Declarations
#-------------------------------
data "external" "env" {
  program = ["jq", "-n", "env"]
}

resource "databricks_secret_scope" "main" {
  name                     = "application"
  initial_manage_principal = "users"
}

resource "databricks_secret" "main" {
  key          = "service_principal_key"
  string_value = data.external.env.result.ARM_CLIENT_SECRET
  scope        = databricks_secret_scope.main.name
}

data "databricks_node_type" "main" {
  local_disk = true
}

data "databricks_spark_version" "main" {
  long_term_support = true
}

resource "databricks_cluster" "main" {
  cluster_name            = "main"
  spark_version           = data.databricks_spark_version.main.id
  node_type_id            = data.databricks_node_type.main.id
  autotermination_minutes = 30

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  is_pinned = true
}

data "databricks_group" "main" {
  display_name = "admins"
}
