{ config, pkgs, ... }:

{
  home.username = "cooper";
  home.homeDirectory = "/home/cooper";
  home.stateVersion = "25.05"; # current home-manager ver
  programs.home-manager.enable = true; # Home Manager can install and manage itself

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      btw = "echo i use nixos btw";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-btw";
      config = "sudo vim /etc/nixos/configuration.nix";
      homemanager = "sudo vim /etc/nixos/home.nix";
    };
  };

  home.packages = with pkgs; [
    bat
    fastfetch
    nnn

    # archives
    zip
    xz
    unzip 

    # networking
    nmap
    dnsutils
    ldns

    # misc utilities
    which
    tree
    file
    lsof
    usbutils
    ethtool
    sysstat
    lazygit

    # nix
    nix-output-monitor
  ];

  programs.git = {
    enable = true;
    userName = "cglavin50";
    userEmail = "cooperglavin@gmail.com";
    
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };
}
