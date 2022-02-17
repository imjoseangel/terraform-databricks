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
  string_value = data.external.env.ARM_CLIENT_SECRET
  scope        = databricks_secret_scope.main.name
}
