let
    pkgs = import <nixpkgs> {
        config.allowUnfree = false;
        overlays = [ ];
    };

    ghcenv = pkgs.haskellPackages.ghcWithPackages (p: with p; [ xmonad xmonad-contrib ]);
in
pkgs.stdenv.mkDerivation {
  name = "xmonad-dev-env";
  buildInputs = [ ghcenv ];
}
