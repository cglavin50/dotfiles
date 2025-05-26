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
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-btw --show-trace --print-build-logs --verbose";
      config = "sudo vim /etc/nixos/configuration.nix";
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

    # general stack
    mako
    ranger
    wofi

    # hyprland
    waybar

    # apps
    vesktop
  ];

  programs.git = {
    enable = true;
    userName = "cglavin50";
    userEmail = "cooperglavin@gmail.com";
    
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = (builtins.fromJSON (builtins.readFile ./waybar/config.jsonc));
    };
    style = (builtins.readFile ./waybar/styles.css);
  };

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
}
