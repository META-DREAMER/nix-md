# MacBook Pro configuration
{ config, pkgs, username, hostname, ... }:

{
  # Used for backwards compatibility
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

}