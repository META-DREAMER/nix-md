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
      # You can add fish plugins here if needed
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
} 