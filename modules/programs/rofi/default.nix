{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    modes = [ "drun" ];
    theme = ./configs/launcher.rasi;
  };

  home.packages = with pkgs; [
    rofi-pulse-select
  ];
  xdg.configFile."rofi/volume.rasi".source = ./configs/volume.rasi;
}
