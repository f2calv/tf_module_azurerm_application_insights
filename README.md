---
title: Terraform Module for Azure Application Insights
description: Provision Azure Application Insights with a caller-owned Log Analytics workspace
---

Provisions an [Azure Application Insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) instance against a caller-supplied [Log Analytics workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace).

The workspace is owned by the caller rather than this module, so one workspace can back several Application Insights instances and its lifecycle stays independent of them.

## Usage

```hcl
module "appinsights" {
  source              = "git::https://github.com/f2calv/tf_module_azurerm_application_insights.git//src?ref=v0.3.0"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  appinsights_name    = "my-app-insights"
  workspace_id        = azurerm_log_analytics_workspace.this.id
  tags                = { environment = "dev" }
}
```

## Variables

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `resource_group_name` | `string` | Required | Name of the parent resource group |
| `location` | `string` | `West Europe` | Location of the parent resource group |
| `appinsights_name` | `string` | Required | Name of the Application Insights instance |
| `workspace_id` | `string` | Required | Resource ID of the Log Analytics workspace backing this instance |
| `daily_data_cap_in_gb` | `number` | `1` | Daily data volume cap in GB |
| `retention_in_days` | `number` | `30` | Retention period in days for Application Insights |
| `tags` | `map(string)` | `{}` | Any tags that should be present on the resources |

## Outputs

| Name | Sensitive | Description |
| --- | --- | --- |
| `id` | No | The ID of the Application Insights instance |
| `name` | No | The name of the Application Insights instance |
| `location` | No | The location of the Application Insights instance |
| `connection_string` | Yes | The connection string of the Application Insights instance |
| `app_id` | No | The App ID associated with the Application Insights instance |
| `workspace_id` | No | The ID of the Log Analytics workspace backing this instance |
