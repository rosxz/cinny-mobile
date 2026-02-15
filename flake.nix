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
      buildInputs = [ pkgs.nodejs_22 pkgs.android-studio pkgs.steam-run pkgs.openjdk17 ];
      # TODO linkage for gradle
      # TODO use androidsdk instead of android-studio
      JAVA_HOME = pkgs.openjdk17;
      CAPACITOR_ANDROID_STUDIO_PATH = "${pkgs.android-studio}/bin/android-studio";
    };
    packages.${system}.default = self.packages.${system}.hello;

  };
}
