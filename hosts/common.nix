# defines common modules across all machines
{
  inputs,
  outputs,
  pkgs,
  username,
  browser,
  terminal,
  timezone,
  self,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/hardware/interception-tools/interception-tools.nix
    # ../modules/hardware/interception-tools/default.nix
    # ../modules/desktop/greetd
    ../modules/desktop/dms/greeter.nix
    # ../modules/programs/flameshot
    ../modules/desktop/niri/system.nix
    ../modules/programs/thunar
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # enable 'sudo'
  };

  users.users.noah = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # enable 'sudo'
  };

  nixpkgs.config.allowUnfree = true; # move this?
  security.polkit.enable = true;

  # xdg setup for wm
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portag"
  ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # tailscale enabled for homelab
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--accept-routes"
    ];
  };

  # common home-manager options for all systems
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    # TODO - clean this up?
    extraSpecialArgs = {
      inherit spicePkgs;
    };
    # IMPORT OUR MODULES
    sharedModules = [
      ../modules/programs/minecraft

      # ../modules/desktop/hyprland
      ../modules/desktop/niri
      inputs.niri.homeModules.niri

      # ../modules/desktop/noctalia
      # inputs.noctalia.homeModules.default

      ../modules/programs/nautilus

      ../modules/desktop/dms
      inputs.dms.homeModules.dankMaterialShell.default
      inputs.danksearch.homeModules.dsearch
      inputs.dms.homeModules.dankMaterialShell.niri

      # ../modules/desktop/waybar
      ../modules/programs/tmux
      inputs.nixvim.homeModules.nixvim # pass in homeManager module so nixvim can access
      ../modules/programs/nixvim
      ../modules/programs/zsh
      inputs.matugen.nixosModules.default
      ../modules/programs/matugen
      ../modules/programs/kitty
      # inputs.nixcord.homeModules.nixcord
      # ../modules/programs/nixcord
      # inputs.hyprpanel.homeManagerModules.hyprpanel
      # ../modules/desktop/hyprpanel
      ../modules/desktop/dunst
      # ../modules/desktop/mako
      inputs.zen-browser.homeModules.beta
      inputs.zen-nebula.homeModules.default
      ../modules/programs/zen
      ../modules/programs/rofi
      ../modules/programs/wofi
      ../modules/programs/ranger
      inputs.spicetify-nix.homeManagerModules.spicetify
      # spicePkgs
      ../modules/programs/spicetify
      ../modules/programs/cava
      # ../modules/desktop/hyprlock
      ../modules/programs/aider-chat # manages our aider config
      inputs.agenix.homeManagerModules.default
    ];

    # for our user
    users.${username} = {pkgs, ...}: {
      # home-manager can install and manage itself
      programs.home-manager.enable = true;

      xdg.enable = true;

      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.11";
      home.sessionVariables = {
        browser = browser;
        terminal = terminal;
      };

      # personal git config
      programs.git = {
        enable = true;
        userName = "cglavin50";
        userEmail = "cooperglavin@gmail.com";
        extraConfig = {
          push.autoSetupRemote = true;
        };
      };

      # ssh-agent for ssh-keys
      programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";
        includes = [
          "~/dotfiles/modules/programs/ssh/github_ssh_conf"
          "~/dotfiles/modules/programs/ssh/homelab_rpi"
        ];
      };

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      # default packages that don't require configuration
      # GENERAL PACKAGES
      home.packages = with pkgs; [
        # archives
        zip
        xz
        unzip

        # networking
        nmap
        dnsutils
        ldns

        # audio
        playerctl

        # video
        ffmpeg
        wf-recorder
        vlc
        mpv

        zenity

        # misc
        jq
        bat
        btop
        nnn
        wget
        which
        tree
        file
        usbutils
        ethtool
        sysstat

        fuzzel # launcher

        # surely there's a better way to do this
        # inputs.quickshell.packages.${pkgs.system}.default

        tree-sitter

        papirus-icon-theme

        interception-tools
        interception-tools-plugins.caps2esc

        bitwarden-desktop

        # terminal
        alacritty # many wms use as default
        git
        htop
        tldr
        ripgrep
        kubectl
        helm

        clonehero

        playerctl

        # browsers
        firefox
        google-chrome # for coding assessments

        obsidian
        # vesktop
        vesktop

        # theming
        matugen
        swww
        # inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default # rose-pine hyprcursor from flake
        nix-prefetch

        # games?
        osu-lazer
      ];
    };
  };

  # bootloader?

  time.timeZone = timezone;

  # global networking?
  networking = {
    networkmanager.enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-hyprland
  #     xdg-desktop-portal-gtk # add GTK support
  #   ];
  #
  #   config = {
  #     common = {
  #       default = ["hyprland" "gtk"];
  #     };
  #   };
  # };

  # login manager? ssdm?

  # sound
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.dbus.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # pipewire configuration manager
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
          bluetooth.autoswitch-to-headset-profile = false
        '')
      ];
    };
  };

  # terminal + fonts
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
  programs.zsh.enable = true; # adding this here to prevent error, configured in home-manager
  users.defaultUserShell = pkgs.zsh; # right place?

  # setting defaults for xdg, as apparently xdg doesn't set them before env.variables are set
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";

    NIXOS_OZONE_WL = "1";

    templates = "${self}/dev-shells";
  };

  # nix
  programs = {
    nh = {
      enable = true;
      # automatic garbage collection
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
      flake = "/home/${username}/dotfiles";
    };
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
    optimise.automatic = true;
    package = pkgs.nixVersions.latest;
  };
  system.stateVersion = "25.11";
}
