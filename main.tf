#-------------------------------
# Environment Variables and Data
#-------------------------------

data "external" "env" {
  program = ["python", "-c", "import sys,os,json;json.dump(dict(os.environ), sys.stdout)"]
}

#-------------------------------
# Data Sources
#-------------------------------

data "databricks_group" "admins" {
  display_name = "admins"
}

#-------------------------------
# Resources
#-------------------------------

resource "databricks_user" "main" {
  count                = length(var.admin_users)
  user_name            = var.admin_users[count.index]
  allow_cluster_create = true
}

resource "databricks_group_member" "main" {
  count     = length(var.admin_users)
  group_id  = data.databricks_group.admins.id
  member_id = databricks_user.main[count.index].id
}
