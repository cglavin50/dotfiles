{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	# import previous config.nix to keep existing system
	./configuration.nix

	# nvidia config
	./modules/nvidia.nix

	# hyprland
	./modules/hyprland.nix

	# greetd DM
	./modules/greetd.nix

	# make home-manager a module of nixos such that it's deployed automatically on switch
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;

	  home-manager.users.cooper = import ./home/home.nix;

	  home-manager.backupFileExtension = ".backup";
	}
      ];
    };
  };
}
