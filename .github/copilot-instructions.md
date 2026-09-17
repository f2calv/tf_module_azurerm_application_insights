# Copilot Instructions

## Shared Instructions

Shared Copilot instruction files are maintained centrally in the [.github](https://github.com/f2calv/.github) repository under `instructions/`, and are applied to every workspace from the VS Code user profile via `~/.copilot/instructions`. They are deliberately not copied into this repository, so a change there takes effect everywhere without a pull request here.

Everything below is specific to this repository.

## Workspace Ownership

The module never creates a Log Analytics workspace. The caller owns the workspace and passes its resource identifier in, so that several modules can share one workspace. The `removed` blocks in `src/main.tf` are migration aids for consumers upgrading from the version that created its own workspace, and must be deleted once every consumer has applied.
