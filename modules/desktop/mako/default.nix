{
  config,
  pkgs,
  ...
}: {
  services.mako = {
    enable = true;
    anchor = "top-right";
    margin = "10";
  };

  home.packages = with pkgs; [
    libnotify # testing
  ];
}
