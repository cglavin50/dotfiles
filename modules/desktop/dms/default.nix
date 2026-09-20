{pkgs, ...}: {
  # programs.dsearch.enable = true;

  # not exposed to home manager
  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "niri";
  #   configHome = "/home/cooper";
  # };

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # niri.includes = {
    #   enableKeybinds = true; # Sets static preset keybinds
    #   enableSpawn = true; # Auto-start DMS with niri and cliphist, if enabled
    # };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    # enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    # plugins
    plugins = {
      BatteryAlert = {
        enable = true;
        src =
          pkgs.fetchFromGitHub {
            owner = "AvengeMedia";
            repo = "dms-plugins";
            rev = "8fa7c5286171c66a209dd74e9a47d6e72ccfdad6";
            hash = "sha256-0RXRgUXXoX+C0q+drsShjx2rCTdmqFzOCR/1rGB/W2E=";
          }
          + "/DankBatteryAlerts";
      };
      K8sManager = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "psyreactor";
          repo = "dms-kubernetes";
          rev = "6134233f839cce7796b1bd230e15f19b890125da";
          hash = "sha256-o2FDz3q4ACF8ek3s0x2KDbrvGzv8AFEg2O2Q9vDDl8M=";
        };
      };
      Tailscale = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "cglavin50";
          repo = "dms-tailscale";
          rev = "554b5d0373861b67890abef92d0c535b58f22724";
          hash = "sha256-JrUvxTp9fd5+3wxuSAUZXIl6EjCoyFD9D5kR4vTurfU=";
        };
      };

      wallpaperCarousel = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "motor-dev";
          repo = "wallpaperCarousel";
          rev = "c08fbb92c39d4d778bb08e520cfd96e395594440";
          hash = "sha256-t70CBhiEBYHa9HvPpCZnfA8eCOWhUlXc6SUa9VprFNE=";
        };
      };
      # Note: won't run on stable dms
      # MediaPlayer = {
      #   enable = true;
      #   src = pkgs.fetchFromGitHub {
      #     owner = "arrifat346afs";
      #     repo = "mediaPlayer";
      #     rev = "71006dc92ae16e3eeb29870cedaa85a2caf08de0";
      #     hash = "sha256-fTKVHvHLqLE69dO3gW38yYJCFKnifSlk9iO/cPgnowA=";
      #   };
      # };
    };

    # anything we want to change from default settings
    settings = {
      # dynamic theming
      currentThemeName = "dynamic";
      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      blurWallpaperOnOverview = true;
      syncModeWithPortal = true;
      iconTheme = "System Default";
      borderColor = "surfaceText";
      widgetOutlineColor = "primary";
      gtkThemingEnabled = false;
      qtThemingEnabled = false;
      terminalsAlwaysDark = true;

      # font
      fontFamily = "FiraCode Nerd Font";
      monoFontFamily = "JetBrainsMonoNL Nerd Font Propo";

      # dock config
      showDock = true;
      dockAutoHide = true;
      dockGroupByApp = true;
      dockOpenOnOverview = true;
      dockPosition = 1;
      dockBottomGa = 0;
      dockMargin = 0;
      dockIconSize = 40;
      dockIndicatorStyle = "line";
      dockBorderEnabled = true;
      dockBorderColor = "secondary";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;

      # widget config
      widgetBackgroundColor = "sch";
      widgetColorMode = "colorful";
      use24HourClock = false;
      showSeconds = true;
      useFahrenheit = true;
      privacyShowMicIcon = false;
      privacyShowCameraIcon = false;
      privacyShowScreenShareIcon = false;
    };
  };

  # home.packages = with pkgs; [
  #   dms-shell
  #   quickshell
  #   khal
  # ];
  #
  # programs.dms-shell = {
  #   enable = true;
  #   package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  #
  #   systemd = {
  #     enable = true; # Systemd service for auto-start
  #     restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
  #   };
  #
  #   # Core features
  #   enableSystemMonitoring = true; # System monitoring widgets (dgop)
  #   enableVPN = true; # VPN management widget
  #   enableDynamicTheming = true; # Wallpaper-based theming (matugen)
  #   enableAudioWavelength = true; # Audio visualizer (cava)
  #   enableCalendarEvents = true; # Calendar integration (khal)
  #   enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
  # };
  #

  # xdg.configFile."khal/config".text = ''
  #   [calendars]
  #   # Add your calendar configurations here
  #   # Example:
  #   # [[local_calendar]]
  #   # path = ~/.local/share/khal/calendars/default
  #   # color = dark blue
  # '';
  #
  # xdg.configFile."dms/settings.json".text = builtins.toJSON {
  #   # dynamic theming
  #   currentThemeName = "dynamic";
  #   matugenScheme = "scheme-tonal-spot";
  #   runUserMatugenTemplates = true;
  #   blurWallpaperOnOverview = true;
  #   syncModeWithPortal = true;
  #   iconTheme = "System Default";
  #   borderColor = "surfaceText";
  #   widgetOutlineColor = "primary";
  #   gtkThemingEnabled = false;
  #   qtThemingEnabled = false;
  #   terminalsAlwaysDark = true;
  #
  #   # font
  #   fontFamily = "FiraCode Nerd Font";
  #   monoFontFamily = "JetBrainsMonoNL Nerd Font Propo";
  #
  #   # dock config
  #   showDock = true;
  #   dockAutoHide = true;
  #   dockGroupByApp = true;
  #   dockOpenOnOverview = true;
  #   dockPosition = 1;
  #   dockBottomGa = 0;
  #   dockMargin = 0;
  #   dockIconSize = 40;
  #   dockIndicatorStyle = "line";
  #   dockBorderEnabled = true;
  #   dockBorderColor = "secondary";
  #   dockBorderOpacity = 1;
  #   dockBorderThickness = 1;
  #
  #   # widget config
  #   widgetBackgroundColor = "sch";
  #   widgetColorMode = "colorful";
  #   use24HourClock = false;
  #   showSeconds = true;
  #   useFahrenheit = true;
  #   privacyShowMicIcon = false;
  #   privacyShowCameraIcon = false;
  #   privacyShowScreenShareIcon = false;
  # };
}
