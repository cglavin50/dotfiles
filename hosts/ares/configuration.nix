{
  pkgs,
  hostname,
  username,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../common.nix

    # modules
    ../../modules/hardware/nvidia.nix
    ../../modules/programs/steam
    # ../../modules/programs/home-assistant
  ];

  # Use the systemd-boot EFI boot loader. Move to common?
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.cpuFreqGovernor = "performance";

  # If on WiFi
  networking.networkmanager.enable = true;
  users.users.${username}.extraGroups = [
    "networkmanager"
  ];

  networking.hostName = hostname;
  networking.nameservers = [
    # "192.168.1.10"
    "1.1.1.1"
    "8.8.8.8"
  ]; # use homelab on this machine
  networking.networkmanager.dns = "none"; # prevent NM from overriding adguard DNS

  environment.systemPackages = with pkgs; [
    vim
  ];
  system.stateVersion = "25.11"; # Did you read the comment?
}
