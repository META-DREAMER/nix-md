# Home Manager configuration
{ pkgs, ... }: {
  home.stateVersion = "23.11";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # Add your user-specific packages here
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "META_DREAMER";
    userEmail = "h@md.wtf";
  };

  # Shell configuration (fish)
#   programs.fish = {
#     enable = true;
#     interactiveShellInit = ''
#       # Your fish shell customizations here
#     '';
#   };
} 