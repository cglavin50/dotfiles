{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
    gnome.gvfs
  ];
}
