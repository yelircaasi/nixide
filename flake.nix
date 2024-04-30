{
  description = "A minimal nvim config, modular with nix, based on copper";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/44c70a37071aff4360ff5453fb04e107680d1f70";
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, flake-utils, self, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (import ./helpers.nix { inherit pkgs inputs; }) mkNeovim;

        # inherit (import ./overlays.nix { inherit lib; }) ;

      in
      {
        packages = {
          default = mkNeovim {};
        };
      });
}