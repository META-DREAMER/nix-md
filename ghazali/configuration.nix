# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.openssh.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     curl
     gitMinimal
  ];
  
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUpK4ajlqDPu2mY1XBNYMSC6MqxdwQanuQJ3fyLzmwgaO8xb+rdbIvyIcvuuV61H2SG6IP3tPigevXfV77iJpf0fhvfNckRfQpz1GRcbdd6wQUCXR5My55kLj2MFNk37yqcqhIRPkQVMQ+ZUjKeICoDkqryoRRtLEzCayNJK3WII+lLpL30SbHTXzUQjcTbHAqOhvZiSn5SeSVBWPispPEwPjV4Ym1EsneHKqg+6MLrDZ3Up+nkzpune97Q7URTzqLj2WvQEe7Q3xaYkmImBCldhPfHkZ4YgcxWtng5hZtAeEDFJ2+L50M6DwfXeJPowxq+Ovkia1jmeAML1dxl7vyERAoUswJhiosuJzesxJkCf6RyfrhDzqI1CSXm9hr4i3r7ivhlk3B1VbbauaqTARZpjB0nYl6pI9ttHhPoqpdjDo4s49EI3pLM0XHa3ss0JCpQtpN69k9gLJ5jcbAi2HCc3VJjf9Kc2X+LE71oBe2g2mSj8tUuGcCpExBR6W9fF0= h@md.wtf"
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
