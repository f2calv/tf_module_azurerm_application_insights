variable "resource_group_name" {
  type        = string
  description = "Name of the parent resource group."
}

variable "location" {
  type        = string
  description = "Location of the parent resource group."
  default     = "West Europe"
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
}

variable "appinsights_name" {
  type        = string
  description = "Name of the Application Insights instance (also used for the Log Analytics workspace)."
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "Daily data volume cap in GB."
  default     = 1
}

variable "retention_in_days" {
  type        = number
  description = "Retention period in days for both Application Insights and Log Analytics."
  default     = 30
}
