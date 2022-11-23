{config, pkgs, user, ...}:
{
  imports = 
    [(import ./programs/home.nix)];
   home = {
     username = "fantasky";
     homeDirectory = "/home/fantasky";
   };
   programs.home-manager.enable = true;
   home.stateVersion = "22.11";
}
