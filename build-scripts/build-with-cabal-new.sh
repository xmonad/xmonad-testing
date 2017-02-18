#!/bin/sh -eu

################################################################################
# Edit this file and then rename it to ~/.xmonad/build

################################################################################
# The directory holding your source code and Cabal file:
SRC_DIR=~/develop/oss/xmonad-testing

################################################################################
# The name of the executable produced by cabal.  This comes from the
# executable section of your Cabal file.
EXE_NAME=xmonad-testing

################################################################################
# This script will be given a single argument, the path to the
# executable it should produce.
output_file=$1; shift

################################################################################
cd $SRC_DIR

cabal new-configure \
      --enable-optimization \
      --enable-executable-stripping

cabal new-build

find dist-newstyle -type f -executable -name $EXE_NAME \
     -exec mv -u '{}' $output_file ';'
