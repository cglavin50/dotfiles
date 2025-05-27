{ 
  pkgs,
  hostname,
  browser,
  editor,
  terminal,
  ... 
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../common.nix

      # modules
      # ../../modules/hyprland.nix
      ../../modules/hardware/nvidia.nix
    ];

  # Use the systemd-boot EFI boot loader. Move to common?
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    vim
  ];
  system.stateVersion = "25.05"; # Did you read the comment?
}
