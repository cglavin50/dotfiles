{
  config,
  lib,
  pkgs,
  ...
}: {
  services.interception-tools = {
    enable = true;
    plugins = [pkgs.interception-tools-plugins.dual-function-keys];
    udevmonConfig = ''
       - JOB: '${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE'
           DEVICE:
      EVENTS:
        EV_KEY: [KEY_CAPSLOCK, KEY_RIGHTSHIFT, KEY_LEFTSHIFT]
    '';
  };
}
