{ pkgs, ... }:

{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

    # Override all substituters to ensure no old ones are used
    substituters = [
      "https://cache.nixos.org"                     # Official cache
      "https://nix-community.cachix.org"            # Popular community cache
      "https://cache.garnix.io"                     # Fast mirror, good for flakes
    ];
    # Extra settings to ensure substituter behavior
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="  # Official cache key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="  # Community cache key
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="            # Garnix cache key
    ];
    builders-use-substitutes = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}