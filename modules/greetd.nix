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

  # create greeter users for greetd to run in
  users.users.greeter = {
    isSystemUser = true;
    group = "nogroup";
    shell = pkgs.bash;
  };
}
