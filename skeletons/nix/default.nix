{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation {
  name = "project";
  nativeBuildInputs = [ ];
}
