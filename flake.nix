{
  description = "My first flake, based on Sly-Harvey/NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-nebula = {
      url = "github:JustAdumbPrsn/Nebula-A-Minimal-Theme-for-Zen-Browser";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs = { 
    self, 
    nixpkgs,
     ... 
  } @ inputs: let
    inherit (self) outputs; # lets us refer to self.outputs as outputs
    templates = import ./dev-shell;
    settings = {
      username = "cooper";
      EDITOR = "nvim"; # needed? WIP
      browser = "zen";
      terminal = "kitty";

      # system config
      hostname = "nixos-btw";
      timezone = "America/New_York";

      # TODO: generalize for laptop
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
