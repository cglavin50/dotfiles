{
  config,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;

    settings = {
      confirm_os_window_close = 0;
      background_opacity = 0.75;
      padding_width = 0;
      padding_height = 0;
      window_margin_width = 0;
      dynamic_padding = "no";
      line_spacing = 0;
      letter_spacing = 0;
      font_family = "JetBrainsMono Nerd Font";
      font_size = 11.0;
    };

    # matugen theme
    #  include colors.conf
    extraConfig = ''
      include dank-tabs.conf
      include dank-theme.conf
    '';
  };
}
