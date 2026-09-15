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

#Migration aid: the workspace this module used to create is now owned by the caller. Forget it from
#state without destroying it, since the caller already manages the same Azure resource. Both the
#pre-v0.1.1 and current resource names are covered. Delete once every consumer has applied.
removed {
  from = azurerm_log_analytics_workspace.my_log_analytics_workspace

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_log_analytics_workspace.this

  lifecycle {
    destroy = false
  }
}
