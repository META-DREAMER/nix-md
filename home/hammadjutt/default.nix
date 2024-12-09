# Home Manager configuration
{ pkgs, ... }: {
  home.stateVersion = "23.11";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    starship    # For shell prompt
    zoxide      # For smart directory jumping
    llvm        # For LLVM toolchain
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "META_DREAMER";
    userEmail = "h@md.wtf";
  };

  # Starship prompt configuration
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Shell configuration (fish)
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      # iTerm2 integration
      test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish ; or true
    '';

    shellInit = ''
      # Environment variables
      set -gx EDITOR nano
      set -gx SOPS_AGE_KEY_FILE ~/.config/sops/age/keys.txt
      
      # Kubeconfig setup
      set -gx KUBECONFIG (find ~/.kube/clusters -type f ! -name '.DS_Store' | gsed ':a;N;s/\n/:/;ba')
      
      # Foundry
      set -gx PATH $PATH /Users/hammadjutt/.foundry/bin
      
      # Bun
      set -gx BUN_INSTALL "$HOME/.bun"
      set -gx PATH $BUN_INSTALL/bin $PATH
      
      # LLVM configuration
      set -gx PATH /opt/homebrew/opt/llvm/bin $PATH
      set -gx LLVM_CONFIG_PATH /opt/homebrew/opt/llvm/bin/llvm-config
      set -gx LIBCLANG_PATH /opt/homebrew/opt/llvm/lib
    '';

    plugins = [
      # Kubectl completions
      {
        name = "fish-kubectl-completions";
        src = pkgs.fetchFromGitHub {
          owner = "evanlucas";
          repo = "fish-kubectl-completions";
          rev = "ced676392575d618d8b80b3895cdc3159be3f628";  # Latest commit as of early 2024
          sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
        };
      }
      # Nix environment support
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";  # Latest commit as of early 2024
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
  };

  # Zoxide configuration
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Additional environment variables can be set here
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Add fnm (Fast Node Manager) if you're using it
  programs.fnm = {
    enable = true;
    enableFishIntegration = true;
  };
} 