# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
resource "azurerm_application_insights" "this" {
  name                 = var.appinsights_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  application_type     = "web"
  daily_data_cap_in_gb = var.daily_data_cap_in_gb
  retention_in_days    = var.retention_in_days
  tags                 = var.tags
  workspace_id         = var.workspace_id
}
