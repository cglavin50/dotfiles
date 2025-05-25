# modules/greetd.nix
{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    vt = 1;

    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/greet";
        user = "cooper";
      };
    };
  };
}
