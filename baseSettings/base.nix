{ config , pkgs, ... }:
{
  imports = [
    ./timezone.nix
    ./fcitx5/default.nix
    ./external.nix
    ./fonts.nix
    ./nvidia/nvidia.nix
  ];
}
