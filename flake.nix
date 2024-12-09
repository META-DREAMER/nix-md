{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    mkDarwinSystem = {
      system ? "aarch64-darwin",
      username,
      hostname,
    }: darwin.lib.darwinSystem {
      inherit system;
      specialArgs = inputs // {
        inherit username hostname;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
	      home-manager.backupFileExtension = "backup"; 
		  home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home/${username};
        }
      ];
    };

    mkLinuxSystem = {
      system ? "x86_64-linux",
      username,
      hostname,
    }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs // {
        inherit username hostname;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home/${username};
        }
      ];
    };
  in {
    # Darwin Configurations
    darwinConfigurations = {
      mdmbp = mkDarwinSystem {
        username = "hammadjutt";
        hostname = "mdmbp";
      };
    };

    # NixOS Configurations
    nixosConfigurations = {
      mdserver = mkLinuxSystem {
        username = "md";
        hostname = "mdserver";
      };
    };

    # Nix code formatter
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}