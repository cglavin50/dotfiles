{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (flameshot.override {enableWlrSupport = true;})
  ];

  # programs.flameshot = {
  #   enable = true;
  #   override = {
  #     enableWlrSupport = true;
  #   };
  #   settings.General = {
  #     showStartupLaunchMessage = false;
  #     copyPathAfterSave = true;
  #   };
  # };
}
