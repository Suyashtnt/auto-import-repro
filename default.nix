{ pkgs, stdenv, callPackage, nodejs, nodePackages, writeShellScriptBin }:

let
  generated = callPackage ./nix { inherit nodejs; };
  node2nix = writeShellScriptBin "node2nix" ''
    ${nodePackages.node2nix}/bin/node2nix \
      --development \
      -l package-lock.json \
      -c ./nix/default.nix \
      -o ./nix/node-packages.nix \
      -e ./nix/node-env.nix
  '';

in {
  inherit (generated) nodeDependencies;

  static = stdenv.mkDerivation {
    name = "AfrWeb-frontend";
    src = ./.;
    buildInputs = [ nodejs ];
    buildPhase = ''
      ln -s ${generated.nodeDependencies}/lib/node_modules ./node_modules
      export PATH="${generated.nodeDependencies}/bin:$PATH"
      npm run build
    '';
    installPhase = ''
      cp -r dist $out/
    '';
  };

  shell = generated.shell.override {
    buildInputs = with pkgs; [ node2nix rnix-lsp nodePackages.svelte-language-server nodePackages.typescript-language-server];
  };
}