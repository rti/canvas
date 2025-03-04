{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
      };
    in
    {
      # run with nix develop .
      devShells."${system}".default = (import ./shell.nix) { inherit pkgs; };
    };
}
