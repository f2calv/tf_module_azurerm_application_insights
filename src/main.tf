#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
resource "azurerm_application_insights" "this" {
  name                 = var.appinsights_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  application_type     = "web"
  daily_data_cap_in_gb = 1  #default 100
  retention_in_days    = 30 #default 90
  tags                 = var.tags
  workspace_id         = azurerm_log_analytics_workspace.my_log_analytics_workspace.id
}

#terraform import -var-file='../dev.tfvars' module.rg_core_appinsights.azurerm_log_analytics_workspace.my_log_analytics_workspace /subscriptions/ace4a478-0496-41b9-8bd4-69efd3e7c035/resourceGroups/infra-core-rg/providers/microsoft.operationalinsights/workspaces/cascap
resource "azurerm_log_analytics_workspace" "my_log_analytics_workspace" {
  name                = var.appinsights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018" #todo: change to Free sku?
  retention_in_days   = 30
  tags                = var.tags
}
