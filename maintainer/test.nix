# An environment for testing `xmonad --recompile'.

with (import <nixpkgs> {});

let hask = haskell.packages.ghc7103.ghcWithPackages (p:
             [ p.xmonad p.xmonad-contrib ]);

in stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    # GHC:
    hask
  ];
}
