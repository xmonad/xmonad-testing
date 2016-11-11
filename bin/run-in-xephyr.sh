#!/bin/sh -eu

################################################################################
ARCH=`uname -m`
OS=`uname -s | tr '[A-Z]' '[a-z]'`

################################################################################
if [ -d .stack-work ]; then
echo "stack build detected"
BIN_PATH=`stack path --dist-dir`/build/xmonad-testing
elif [ -d dist-newstyle ]; then
echo "cabal build detected"
BIN_PATH=`find dist-newstyle/ -type f -executable -name xmonad-testing -printf '%h'`
else
  echo "you need to build xmonad-testing first, see README for instructions"
  exit 1
fi

RAW_BIN=$BIN_PATH/xmonad-testing
ARCH_BIN=$BIN_PATH/xmonad-$ARCH-$OS

################################################################################
cp -p $RAW_BIN $ARCH_BIN

################################################################################
set -x

( Xephyr :5 -ac -br -terminate +xinerama -screen 800x600 &
  sleep 2 && env DISPLAY=:5 $ARCH_BIN
)
