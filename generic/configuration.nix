{ config, pkgs, ... }:

{
  # Enable SSH server
  services.openssh.enable = true;

  # Set your user and SSH key
  users.users.md = {
    isNormalUser = true;
    home = "/home/md";
    description = "METADREAMER";
    extraGroups = [ "wheel" ];  # Add to sudoers group
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUpK4ajlqDPu2mY1XBNYMSC6MqxdwQanuQJ3fyLzmwgaO8xb+rdbIvyIcvuuV61H2SG6IP3tPigevXfV77iJpf0fhvfNckRfQpz1GRcbdd6wQUCXR5My55kLj2MFNk37yqcqhIRPkQVMQ+ZUjKeICoDkqryoRRtLEzCayNJK3WII+lLpL30SbHTXzUQjcTbHAqOhvZiSn5SeSVBWPispPEwPjV4Ym1EsneHKqg+6MLrDZ3Up+nkzpune97Q7URTzqLj2WvQEe7Q3xaYkmImBCldhPfHkZ4YgcxWtng5hZtAeEDFJ2+L50M6DwfXeJPowxq+Ovkia1jmeAML1dxl7vyERAoUswJhiosuJzesxJkCf6RyfrhDzqI1CSXm9hr4i3r7ivhlk3B1VbbauaqTARZpjB0nYl6pI9ttHhPoqpdjDo4s49EI3pLM0XHa3ss0JCpQtpN69k9gLJ5jcbAi2HCc3VJjf9Kc2X+LE71oBe2g2mSj8tUuGcCpExBR6W9fF0= h@md.wtf"
    ];
  };

  # Enable sudo without password for wheel group
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Extra configuration
  environment.etc."motd".text = ''
    Welcome META_DREAMER to your NixOS server!
  '';
}