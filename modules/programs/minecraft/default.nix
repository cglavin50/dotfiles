{pkgs, ...}: {
  home.packages = with pkgs; [
    atlauncher # https://atlauncher.com/
  ];
}
