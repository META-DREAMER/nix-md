# MacBook Pro configuration
{ config, pkgs, username, hostname, ... }:

{
  # Used for backwards compatibility
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager.users.hammadjutt = { ... }: {
    # Add this line to automatically backup existing files
    home.activation.checkLinkTargets.backupFileExtension = "backup";
    
    # ... rest of your home-manager configuration ...
  };
} 