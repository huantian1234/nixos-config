# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  user="fantasky";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./baseSettings/base.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree=true;
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nix = {
    settings = {
      substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "https://hyprland.cachix.org"  ];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = "gtk2";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };
  };
  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services = {
     xserver = {
       enable = true;
       displayManager = {
         lightdm.enable = true;   
   #      defaultSession = "xfce";
       };
   #  desktopManager.xfce.enable = true;
   };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

    
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video"]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim 
      wget
      git
      firefox
      home-manager
      binutils
      file 
      clash
      myRepo.clash-for-windows
      alacritty
      waybar
      rofi-wayland
      fcitx5-gtk
      fcitx5-lua
      libsForQt5.fcitx5-qt
      fcitx5-configtool
      wayland
      mpc-cli
      neofetch
      pavucontrol
      pamixer
      networkmanagerapplet
      catppuccin-gtk
      swaybg
      pciutils
      glxinfo
      neovim
      ranger
    ];
  programs.waybar.enable = true; 
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.xwayland.enable = true;
  programs.steam.enable = true;
  programs.proxychains.enable = true;
  programs.proxychains.proxies = {
    myproxy = {
      enable = true;
      type = "socks5";
      host = "127.0.0.1";
      port = 7894;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
   nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        patchPhase = ''
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}

