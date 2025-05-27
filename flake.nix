{
  description = "My first flake, based on Sly-Harvey/NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";


    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # import other flakes like zen-browser to use
  };

  outputs = { 
    self, 
    nixpkgs,
     ... 
  } @ inputs: let
    inherit (self) outputs; # lets us refer to self.outputs as outputs
    settings = {
      username = "cooper";
      editor = "nvim"; # needed? WIP
      browser = "firefox"; # convert to zen
      terminal = "kitty";

      # system config
      hostname = "nixos-btw";
      timezone = "America/New_York";

      # TODO: generalize
      system = "x86_64-linux";
    };
  in {
    nixosConfigurations = {
      ares = nixpkgs.lib.nixosSystem {
	system = settings.system;
	specialArgs = {inherit self inputs outputs;} // settings;
	modules = [./hosts/ares/configuration.nix];
      };
    };
  };
}
