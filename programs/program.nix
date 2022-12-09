{config, pkgs, ...}:
{
  imports = [
    ./desktop/default.nix
    ./development_env/docker.nix
    ./editor/default.nix
    ./alacritty/default.nix
  ];
}
