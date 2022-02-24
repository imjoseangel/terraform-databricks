#-------------------------------
# Data Source Declarations
#-------------------------------
data "external" "env" {
  program = ["jq", "-n", "env"]
}

#-------------------------------
# DB Data Source Declarations
#-------------------------------
data "databricks_node_type" "main" {
  local_disk = true

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

data "databricks_spark_version" "main" {
  long_term_support = true

  depends_on = [
    azurerm_databricks_workspace.main,
    databricks_secret.main
  ]
}

data "databricks_group" "main" {
  display_name = "admins"

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

#-------------------------------
# DB Data Resource Declarations
#-------------------------------

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

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

resource "databricks_workspace_conf" "main" {
  custom_config = {
    "enableIpAccessLists" : true
  }

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

resource "databricks_ip_access_list" "main" {
  label     = "allow_in"
  list_type = "ALLOW"
  ip_addresses = [
    "1.2.3.0/24",
    "1.2.5.0/24"
  ]

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

#-------------------------------
# Databricks Secrets
#-------------------------------

resource "databricks_secret_scope" "main" {
  name                     = "application"
  initial_manage_principal = "users"

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

resource "databricks_secret" "main" {
  key          = "service_principal_key"
  string_value = data.external.env.result.ARM_CLIENT_SECRET
  scope        = databricks_secret_scope.main.name

  depends_on = [
    azurerm_databricks_workspace.main
  ]
}

