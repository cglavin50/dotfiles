{ pkgs, config, lib, inputs, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # modesetting is required
    modesetting.enable = true;

    # open-source, seems buggy but will need to play around with later
    open = false;

    # Enable nvidia menu, `nvidia-settings`
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
