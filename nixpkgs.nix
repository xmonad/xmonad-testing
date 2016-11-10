with (import <nixpkgs> {});

stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    # GHC:
    haskell.packages.lts-6_7.ghc

    # Non-Haskell Dependencies:
    pkgconfig
    xorg.libX11
    xorg.libXext
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXrender
    xorg.libXft
  ];
}
