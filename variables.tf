variable "name" {
  description = "value of the name variable"
  type        = string
}

#-------------------------------
# Databricks Variables
#-------------------------------

variable "admin_users" {
  description = "Define the list of admin users"
  type        = list(string)
  default     = ["josea.munoz@gmail.com"]
}
