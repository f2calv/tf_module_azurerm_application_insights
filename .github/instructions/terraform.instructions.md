---
description: 'Terraform authoring conventions for this reusable module — formatting, versions, variables, resources, outputs and security.'
applyTo: '**/*.tf,**/*.tfvars,**/*.hcl'
---

# Terraform

This repository publishes a single reusable module under `src/`, consumed over a pinned Git source. It declares no backend, no provider configuration and no state of its own — the calling root module owns all three.

## Formatting

- Run `terraform fmt -recursive` before every commit. All `.tf` files must pass with no changes.
- 2-space indentation, Terraform's default. Let `fmt` handle argument alignment; never hand-align.
- Use `#` for comments. Avoid `//` — `fmt` leaves it untouched, so it drifts from the rest of the file.

## Versions

- Declare a `terraform {}` block in `versions.tf` with **permissive lower bounds**: `required_version` for the oldest Terraform the module's syntax needs, and a `required_providers` entry per provider it uses, constrained with `>=` on the supported major.
- **Never pin an exact version here.** A child module pinning `= 4.81.0` cannot be composed with a caller or a sibling module that needs anything else. Exact pins and the dependency lock file belong to the root module.
- **Do not declare `provider` blocks.** Providers are inherited from the caller, which may pass a specific alias via `providers = { ... }`.

## File Conventions

| File | Purpose |
| --- | --- |
| `src/main.tf` | Resource and `data` blocks |
| `src/variables.tf` | Input variable declarations |
| `src/outputs.tf` | Output values |
| `src/versions.tf` | `terraform {}` block with `required_version` and `required_providers` |

- Keep the module focused on a single resource type or a tightly coupled group, and expose all customisation through variables.
- `README.md` documents usage, every variable and every output. Update it in the same commit as any interface change.

## Variables

- Every variable declares a `type` and a `description`. The description states what the value *is*, in one line.
- Names are `snake_case` and descriptive.
- Give a `default` only where a sensible one exists. A value the caller must own — a name, a parent resource id — stays required.
- Prefer a `map(string)` or `map(object({...}))` over parallel lists so `for_each` keys stay stable and readable.

## Resources and Data Sources

- **Name the primary resource `this`.** Secondary resources take a descriptive suffix: `this_pv`, `this_secret`.
- **Registry comment-link above each resource block**, pointing at the provider documentation for that resource type:

  ```hcl
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
  resource "azurerm_application_insights" "this" {
  ```

- **Accept ids rather than creating shared dependencies.** A resource that could reasonably be shared by several callers — a workspace, a resource group, a vnet — is passed in by id, not created here. Creating it inside the module hands its lifecycle to whichever caller happened to instantiate the module first.
- **`for_each` over `count`.** Use `for_each` with a map for any multi-instance resource; it produces stable, readable state keys. Reserve `count` for the boolean on/off idiom, `count = var.feature_enabled ? 1 : 0`.
- **Tags**: every taggable resource sets `tags = var.tags`.
- **No `lifecycle { prevent_destroy = true }` here.** It is the caller's decision and, once published in a module, it blocks a `terraform destroy` the caller may legitimately want.

## Outputs

- Every output declares a `description`.
- Mark every key, password, connection string and certificate output `sensitive = true`.
- Source an output from the resource that owns it, so the value is not silently echoing an input back to the caller.

## Security

- **No secrets in the module.** Never hardcode a key, connection string or credential, and never give a variable a secret default.
- **Sensitive outputs** are marked `sensitive = true` so they are redacted from plan output and CI logs.
- Terraform writes output values into the caller's state, so a sensitive output is only as protected as their state backend. Keep the surface minimal — expose an id or an endpoint rather than a raw key wherever the caller can look the secret up itself.

## Breaking Changes

Adding a required variable, renaming a resource, or removing a resource from a module is a breaking change for every consumer.

- Renaming a resource makes Terraform plan a destroy and create against the caller's existing infrastructure. Ship a `moved` block in the same change so the rename is absorbed automatically.
- Removing a resource the caller still owns elsewhere needs a `removed` block with `lifecycle { destroy = false }`, so it is forgotten from state rather than destroyed. Without one, every consumer has to run `terraform state rm` by hand.
- Tag a release and expect callers to pin to it. A caller tracking a branch ref inherits breaking changes silently, on their next `init`.
- Record the change in the commit message with a `BREAKING CHANGE:` footer.

## Dead Code

Commented-out blocks accumulate fast in Terraform. Delete superseded configuration outright; Git holds the history. Where a block is intentionally dormant rather than dead, keep it commented but prefix it with a one-line reason and, where known, the condition for re-enabling it.
