#!/bin/sh -eu

################################################################################
usage () {
  cat <<EOF
Usage: run-in-xephyr.sh [options]

  -d NxN  Set the screen size to NxN
  -h      This message
  -n NUM  Set the internal DISPLAY to NUM
  -s NUM  Set the number of screens to NUM
EOF
}

################################################################################
ARCH=$(uname -m)
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
SCREENS=1
SCREEN_SIZE="800x600"
DISPLAY_NUMBER=5

################################################################################
while getopts "hs:" o; do
  case "${o}" in
    d) SCREEN_SIZE=$OPTARG
       ;;

    h) usage
       exit
       ;;

    n) DISPLAY_NUMBER=$OPTARG
       ;;

    s) SCREENS=$OPTARG
       ;;

    *) echo; usage
       exit 1
       ;;
  esac
done

shift $((OPTIND-1))

################################################################################
if [ -d .stack-work ]; then
  echo "stack build detected"
  options=""
  [ "${NIX_PATH:-NO}" = "NO" ] || options="--nix"
  BIN_PATH=$(stack path $options --dist-dir)/build/xmonad-testing
elif [ -d dist-newstyle ]; then
  echo "cabal build detected"
  BIN_PATH=$(find dist-newstyle/ -type f -executable -name xmonad-testing -printf '%h')
else
  echo "you need to build xmonad-testing first, see README for instructions"
  exit 1
fi

RAW_BIN=$BIN_PATH/xmonad-testing
ARCH_BIN=$BIN_PATH/xmonad-$ARCH-$OS

################################################################################
cp -p "$RAW_BIN" "$ARCH_BIN"

################################################################################
XMONAD_CONFIG_DIR=$(pwd)/state/config
XMONAD_CACHE_DIR=$(pwd)/state/cache
XMONAD_DATA_DIR=$(pwd)/state/data
export XMONAD_CONFIG_DIR XMONAD_CACHE_DIR XMONAD_DATA_DIR

mkdir -p "$XMONAD_CONFIG_DIR" "$XMONAD_CACHE_DIR" "$XMONAD_DATA_DIR"
echo "xmonad will store state files in $(pwd)/state"

################################################################################
SCREEN_COUNTER=0
SCREEN_OPTS=""
X_OFFSET_CURRENT="0"
X_OFFSET_ADD=$(echo "$SCREEN_SIZE" | cut -dx -f1)

while expr "$SCREEN_COUNTER" "<" "$SCREENS"; do
  SCREEN_OPTS="$SCREEN_OPTS -origin ${X_OFFSET_CURRENT},0 -screen ${SCREEN_SIZE}+${X_OFFSET_CURRENT}"
  SCREEN_COUNTER=$(("$SCREEN_COUNTER" + 1))
  X_OFFSET_CURRENT=$(("$X_OFFSET_CURRENT" + "$X_OFFSET_ADD"))
done

(
  # shellcheck disable=SC2086
  Xephyr $SCREEN_OPTS +xinerama +extension RANDR \
         -ac -br -reset -terminate -verbosity 10 \
         -softCursor ":$DISPLAY_NUMBER" &

  export DISPLAY=":$DISPLAY_NUMBER"
  echo "Waiting for windows to appear..." && sleep 2

  xterm -hold xrandr &
  xterm &
  $ARCH_BIN
)
