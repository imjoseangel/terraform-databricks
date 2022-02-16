#-------------------------------
# Data Source Declarations
#-------------------------------
data "external" "env" {
  program = ["jq", "-n", "env"]
}

resource "databricks_secret_scope" "terraform" {
  name                     = "application"
  initial_manage_principal = "users"
}
