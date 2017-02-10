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

cabal sandbox init

cabal configure --enable-optimization \
                --enable-executable-stripping

cabal install --only-dependencies
cabal build

cp dist/build/$EXE_NAME/$EXE_NAME $output_file
