#!/bin/sh -eu

################################################################################
# Edit this file and then rename it to ~/.xmonad/build

################################################################################
# The directory holding your source code and stack.yaml file:
SRC_DIR=~/develop/oss/xmonad-testing

################################################################################
# The name of the executable produced by stack.  This comes from the
# executable section of your Cabal file.
EXE_NAME=xmonad-testing

################################################################################
# This script will be given a single argument, the path to the
# executable it should produce.
output_file=$1; shift

################################################################################
cd $SRC_DIR
stack build
cp -uf `stack exec which $EXE_NAME` $output_file
