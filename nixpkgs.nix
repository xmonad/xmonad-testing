with (import <nixpkgs> {});

stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    # GHC:
    haskell.packages.ghc7103.ghc

    # Non-Haskell Dependencies:
    pkgconfig
    autoconf
    xorg.libX11
    xorg.libXext
    xorg.libXft
    xorg.libXinerama
    xorg.libXpm
    xorg.libXrandr
    xorg.libXrender
  ];

  shellHook = ''
    # Generate the configure script in X11:
    ( cd x11 && autoreconf -f )
  '';
}
