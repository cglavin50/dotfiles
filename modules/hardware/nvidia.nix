{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # load nvidia driver for Xorg and Wayland
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  hardware.nvidia = {
    # modesetting is required
    modesetting.enable = true;

    # open-source, seems buggy but will need to play around with later
    open = false;

    # Enable nvidia menu, `nvidia-settings`
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    glmark2
    glxinfo
  ];

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
