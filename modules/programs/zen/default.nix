{
  config,
  pkgs,
  ...
}: {
  programs.zen-browser = {
    enable = true;
    # see here: https://mozilla.github.io/policy-templates/
    policies = {
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
    };
  };

  zen-nebula = {
    enable = true;
    profile = "coop";
  };
}
