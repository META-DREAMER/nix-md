# Nix Configuration Modules

This directory contains the modular configuration files for the Nix system:

- `nix-core.nix`: Core Nix settings, including experimental features and basic configurations
- `system.nix`: System-level configurations, including system preferences and defaults
- `apps.nix`: Application installations and their configurations
- `host-users.nix`: User-specific configurations and settings

Each module is designed to be composable and reusable across different hosts. 