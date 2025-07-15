{
  config,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    # default settings for all launchers?
    settings = {
      location = "center";
      allow_markup = true;
      columns = 3;
      insensitive = true;
      hide_scroll = true;
      show-icons = true;
      allow-images = true;
    };
  };

  # xdg.configFile."wofi/themes".source = ./themes;
  xdg.configFile."wofi/scripts".source = ./scripts;
}
