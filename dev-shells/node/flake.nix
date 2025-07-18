{
  description = "Flake for nodeJS-23 development, inspired from SlyHarvey repo";

  inputs.nixpkgs.url = "nixpkgs/nixos-25.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [self.overlays.default];
          };
        });
  in {
    overlays.default = final: prev: rec {
      nodejs = prev.nodejs;

      yarn = prev.yarn.override {inherit nodejs;};
    };

    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [node2nix nodejs nodePackages.pnpm yarn];
      };
    });
  };
}
