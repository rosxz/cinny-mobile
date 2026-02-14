{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {

    devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      # Minimal buildInputs — avoid pulling many deps into the environment.
      buildInputs = [ pkgs.nodejs_20 pkgs.android-studio pkgs.steam-run ];

      CAPACITOR_ANDROID_STUDIO_PATH = "${pkgs.android-studio}/bin/android-studio";
    };
    packages.${system}.default = self.packages.${system}.hello;

  };
}
