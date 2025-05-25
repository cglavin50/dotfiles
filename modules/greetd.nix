# modules/greetd.nix
{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    vt = 1;

    settings = {
      default_session = {
        command = "${pkgs.greetd.greet}/bin/greet";
        user = "greeter";
      };
    };
  };
}
