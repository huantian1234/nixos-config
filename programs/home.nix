{config, pkgs, ...}:
{
  imports = [
    ./desktop/home.nix
    ./editor/home.nix
    ./alacritty/home.nix
  ];
}
