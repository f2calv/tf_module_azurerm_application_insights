# Terraform Module: Azure Application Insights

Provisions an [Azure Application Insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) instance backed by a [Log Analytics workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace).

## Usage

```hcl
module "appinsights" {
  source              = "git::https://github.com/f2calv/tf_module_azurerm_application_insights.git//src?ref=main"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  appinsights_name    = "my-app-insights"
  tags                = { environment = "dev" }
}
```

## Variables

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `resource_group_name` | `string` | — | Name of the parent resource group |
| `location` | `string` | `West Europe` | Location of the parent resource group |
| `appinsights_name` | `string` | — | Name of the Application Insights instance (also used for Log Analytics workspace) |
| `daily_data_cap_in_gb` | `number` | `1` | Daily data volume cap in GB |
| `retention_in_days` | `number` | `30` | Retention period in days for both Application Insights and Log Analytics |
| `tags` | `map(string)` | `{}` | Any tags that should be present on the resources |

## Outputs

| Name | Sensitive | Description |
| --- | --- | --- |
| `id` | No | The ID of the Application Insights instance |
| `name` | No | The name of the Application Insights instance |
| `location` | No | The location of the Application Insights instance |
| `instrumentation_key` | Yes | The instrumentation key (deprecated — use `connection_string`) |
| `connection_string` | Yes | The connection string of the Application Insights instance |
| `app_id` | No | The App ID associated with the Application Insights instance |
| `workspace_id` | No | The ID of the Log Analytics workspace |
