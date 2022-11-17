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
  };
  outputs = inputs @ { self, nixpkgs, hyprland , ... }: 
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
          { programs.hyprland.enable = true;}

          ./configuration.nix
          ./nvidia.nix
        ];
      };
    };
}
