{config, pkgs, ... }:
{
  #network
  networking.networkmanager.enable = true;

  #sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;

  #light
  programs.light.enable = true;
}
