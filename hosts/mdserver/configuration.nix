# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, username, hostname, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Set your time zone
  time.timeZone = "America/Edmonton";

  # Enable SSH server
  services.openssh.enable = true;

  # User account
  users.users.${username} = {
    isNormalUser = true;
    description = "META_DREAMER";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUpK4ajlqDPu2mY1XBNYMSC6MqxdwQanuQJ3fyLzmwgaO8xb+rdbIvyIcvuuV61H2SG6IP3tPigevXfV77iJpf0fhvfNckRfQpz1GRcbdd6wQUCXR5My55kLj2MFNk37yqcqhIRPkQVMQ+ZUjKeICoDkqryoRRtLEzCayNJK3WII+lLpL30SbHTXzUQjcTbHAqOhvZiSn5SeSVBWPispPEwPjV4Ym1EsneHKqg+6MLrDZ3Up+nkzpune97Q7URTzqLj2WvQEe7Q3xaYkmImBCldhPfHkZ4YgcxWtng5hZtAeEDFJ2+L50M6DwfXeJPowxq+Ovkia1jmeAML1dxl7vyERAoUswJhiosuJzesxJkCf6RyfrhDzqI1CSXm9hr4i3r7ivhlk3B1VbbauaqTARZpjB0nYl6pI9ttHhPoqpdjDo4s49EI3pLM0XHa3ss0JCpQtpN69k9gLJ5jcbAi2HCc3VJjf9Kc2X+LE71oBe2g2mSj8tUuGcCpExBR6W9fF0= h@md.wtf"
    ];
  };

  # Enable sudo without password for wheel group
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    htop
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
} 