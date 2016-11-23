with (import <nixpkgs> {});

stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    # GHC:
    haskell.packages.ghc7103.ghc

    # Non-Haskell Dependencies:
    autoconf
    pkgconfig
    xorg.libX11
    xorg.libXext
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXrender
    xorg.libXft
  ];
}
