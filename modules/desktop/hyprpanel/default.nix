{
  config,
  lib,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;

    settings = {
      theme.font = {
        name = "JetBrains Mono";
        size = "16px";
      };
    };
  };
}
