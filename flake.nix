{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    myRepo = {
      url = "github:huantian1234/myNUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      # User Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { self, nixpkgs, hyprland , home-manager, ... }: 
    let
      user = "fantasky";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          #####
          ({
            nixpkgs.overlays = [
              (final: prev: {
                myRepo = inputs.myRepo.packages."${prev.system}";
              })
            ];
          })
          #####
          #hyprland
          hyprland.nixosModules.default
          ./configuration.nix
	  home-manager.nixosModules.home-manager{
	    home-manager.useUserPackages = true;
	    home-manager.useGlobalPkgs = true;
	    home-manager.users.${user} = {
	      imports = [
	        (import ./home.nix)
	      ];
            };
	  }
        ];
      };
    };
}
