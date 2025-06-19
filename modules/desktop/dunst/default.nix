{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    dunst
    libnotify # testing
  ];

  services.dunst = {
    enable = true;
    # configFile = "~/.config/dunst/matugen";
  };
}
