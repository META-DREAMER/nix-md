{
4	  inputs = {
5	    nixpkgs.url = "github:NixOS/nixpkgs";
6	  };
7	
8	  outputs = { self, nixpkgs }: {
9	    packages."aarch64-darwin".default = let
10	      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
11	    in pkgs.buildEnv {
12	      name = "home-packages";
13	      paths = with pkgs; [
14	
15	        # general tools
16	        git
17	
18			# ... add your tools here
19	      ];
20	    };
21	  };
22	
23	}