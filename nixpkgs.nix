with (import <nixpkgs> {});

let ghc = haskell.packages.ghc802;
in
stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    # GHC and friends:
    (ghc.ghcWithPackages (p: with p; [
      cabal-install
      packdeps
    ]))

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

    gnupg # sign tags and releases
    rsync # Needed by xmonad-web/gen-docs.sh
  ];

  shellHook = ''
    # Generate the configure script in X11:
    ( test -d x11 && cd x11 && autoreconf -f )

    # Make stack happy:
    export GPG_TTY=`tty`
  '';
}
