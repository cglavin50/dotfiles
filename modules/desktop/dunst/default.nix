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
    enable = true; # managing conf file on execute due to matugen dynamically creating
  };
}
