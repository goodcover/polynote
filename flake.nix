{
  inputs = {
    gc-nix.url = "github:goodcover/gc-nix?ref=main";
    flake-utils.follows = "gc-nix/flake-utils";
    nixpkgs.follows = "gc-nix/nixpkgs";
  };

  outputs = { self, gc-nix, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        shell = gc-nix.devShells.${system}.jdk11;

        inputs = shell.buildInputs;
      in
      {

        devShell = pkgs.mkShell {
          buildInputs = inputs;
        };

        devShells = gc-nix.devShells;

        pkgs = pkgs;

        rocksdb = shell.rocksdb;
      }
    );
}
