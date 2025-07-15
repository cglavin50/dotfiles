{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    modes = ["drun"];
    theme = ./themes/launcher.rasi; # define default theme for app launcher
  };

  home.packages = with pkgs; [
    rofi-pulse-select
  ];

  xdg.configFile."rofi/themes".source = ./themes;
  xdg.configFile."rofi/scripts".source = ./scripts;
}
