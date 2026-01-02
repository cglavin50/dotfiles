{pkgs, ...}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud # for fps monitoring
    protonup-ng # to install protonGE
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = ''~/.steam/root/compatibilitytools.d'';
  };

  programs.gamemode.enable = true;
}
