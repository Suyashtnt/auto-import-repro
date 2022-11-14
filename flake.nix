{
  description = "Flake utils demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
          inherit system;
      };

      callPackage = pkgs.callPackage;
      writeShellScriptBin = pkgs.writeShellScriptBin;
      stdenv = pkgs.stdenv;

      def = import ./default.nix {
        nodejs = (pkgs.nodejs);
        nodePackages = (pkgs.nodePackages); inherit stdenv callPackage writeShellScriptBin pkgs; 
      };
      in
    {
      devShells.default = def.shell;
    });
}