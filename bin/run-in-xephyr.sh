#!/bin/sh -eu

################################################################################
ARCH=`uname -m`
OS=`uname -s | tr '[A-Z]' '[a-z]'`

################################################################################
BIN_PATH=`stack path --dist-dir`/build/xmonad-testing
RAW_BIN=$BIN_PATH/xmonad-testing
ARCH_BIN=$BIN_PATH/xmonad-$ARCH-$OS

################################################################################
cp -p $RAW_BIN $ARCH_BIN

################################################################################
set -x

( Xephyr :5 -ac -br -terminate +xinerama -screen 800x600 &
  sleep 2 && env DISPLAY=:5 $ARCH_BIN
)
