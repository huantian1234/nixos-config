{config, pkgs, ... }:
{
  #network
  networking = {
    networkmanager.enable = true;
    hosts = {
      "140.82.114.3" = ["github.com"];
      "185.199.111.153" = ["assets-cdn.github.com"];
      "151.101.193.194" = ["github.global.ssl.fastly.net"];
    };
  };

  #sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;

  #light
  programs.light.enable = true;
}
