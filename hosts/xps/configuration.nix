{
  pkgs,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  # Use the systemd-boot EFI boot loader. Move to common?
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  services.upower.enable = true;

  networking.hostName = hostname;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ]; # use homelab on this machine
  networking.networkmanager.dns = "none"; # prevent NM from overriding adguard DNS

  environment.systemPackages = with pkgs; [
    vim
  ];
  system.stateVersion = "25.11"; # Did you read the comment?

  # Enable GNOME
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
}
