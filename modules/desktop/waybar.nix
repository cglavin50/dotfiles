{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ waybar ];
  
  xdg.configFile."waybar/config".source = ../home/waybar/config;
  xdg.configFile."waybar/style.css".source = ../home/waybar/style.css;
}
