output "id" {
  description = "The ID of the Application Insights instance."
  value       = azurerm_application_insights.this.id
}

output "name" {
  description = "The name of the Application Insights instance."
  value       = azurerm_application_insights.this.name
}

output "location" {
  description = "The location of the Application Insights instance."
  value       = azurerm_application_insights.this.location
}

output "instrumentation_key" {
  description = "The instrumentation key of the Application Insights instance (deprecated — use connection_string instead)."
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The connection string of the Application Insights instance."
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}

output "app_id" {
  description = "The App ID associated with the Application Insights instance."
  value       = azurerm_application_insights.this.app_id
}

output "workspace_id" {
  description = "The ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.id
}
