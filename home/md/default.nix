# Home Manager configuration for md user
{ pkgs, ... }: {
  home.stateVersion = "23.11";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    htop
    tmux
    ripgrep
    fd
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "META_DREAMER";
    userEmail = "h@md.wtf";
  };

  # Shell configuration (fish)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Set environment variables
      set -gx EDITOR vim
      set -gx TERM xterm-256color
    '';
  };

  # SSH configuration
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = {
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/id_rsa";
        };
      };
    };
  };
} 