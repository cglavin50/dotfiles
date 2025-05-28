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
}: {
  imports = [ 
    inputs.home-manager.nixosModules.home-manager
    ../modules/hardware/interception-tools/interception-tools.nix
    # ../modules/hardware/interception-tools/default.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # enable 'sudo'
  };

  nixpkgs.config.allowUnfree = true; # move this?

  programs.ssh.startAgent = true;

  # common home-manager options for all systems
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
 
    sharedModules = [
      ../modules/desktop/hyprland # automatically resolves to default.nix
      ../modules/programs/tmux
      inputs.nixvim.homeManagerModules.nixvim # pass in homeManager module so nixvim can access
      ../modules/programs/nixvim
      ../modules/programs/zsh
    ];   

    # for our user


    users.${username} = {pkgs, ...}: {
      # home-manager can install and manage itself
      programs.home-manager.enable = true; 

      xdg.enable = true;

      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.05";
      home.sessionVariables = {
	editor = "nvim";
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
	includes = [ "../modules/programs/ssh/github_ssh_conf" ];
      };

      # default packages that don't require configuration
      home.packages = with pkgs; [
	# archives
	zip
	xz
	unzip

	# networking
	nmap
	dnsutils
	ldns

	# misc
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

	interception-tools
	interception-tools-plugins.caps2esc

	# terminal
	git
	htop
	tldr
	ripgrep

	# TODO remove scaffolding
	kitty
	ranger
	wofi
	firefox
	obsidian
	vesktop
      ];
    };
  };

  # bootloader?
  
  time.timeZone = timezone;

  # global networking?
  networking = {
    networkmanager.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  # login manager? ssdm?

  # sound
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

  # terminal
  # change shell here
  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    fira-code
  ];
  programs.zsh.enable = true; # adding this here to prevent error, configured in home-manager
  users.defaultUserShell = pkgs.zsh; # right place?

  # setting defaults for xdg, as apparently xdg doesn't set them before env.variables are set
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";

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
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
    optimise.automatic = true;
    package = pkgs.nixVersions.latest;
  };
  system.stateVersion = "25.05";
}
