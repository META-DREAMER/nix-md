# Home Manager configuration
{ pkgs, config, ... }: {
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
      
      # FNM integration
      fnm env --use-on-cd | source
    '';

    shellInit = ''
      # Environment variables
      set -gx SOPS_AGE_KEY_FILE ~/.config/sops/age/keys.txt
      
      # Kubeconfig setup
      set -gx KUBECONFIG (find ~/.kube/clusters -type f ! -name '.DS_Store' | gsed ':a;N;s/\n/:/;ba')
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
    ];
  };

  # Zoxide configuration
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Path management
  home.sessionPath = [
    "/opt/homebrew/opt/llvm/bin"
    "${config.home.homeDirectory}/.foundry/bin"
    "${config.home.homeDirectory}/.bun/bin"
  ];

  # Additional environment variables
  home.sessionVariables = {
    EDITOR = "nano";
    LLVM_CONFIG_PATH = "/opt/homebrew/opt/llvm/bin/llvm-config";
    LIBCLANG_PATH = "/opt/homebrew/opt/llvm/lib";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
  };
}  