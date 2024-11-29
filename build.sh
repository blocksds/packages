#!/bin/bash
# build.sh by davidgfnet

# Will build the specified packages.
#
# Example:
#  ./build.sh sdl2 # Builds package SDL2
#
# On GitHub actions it is required to use "--retry" in the first package:
#
#  ./build.sh --retry sdl2

set -e

doretry=""
if [ "$1" == "--retry" ]; then
    doretry="true"
    shift
fi

if [ -z "$1" ]
then
    echo "Specify a package to build!"
    exit 1
else
    pkgdir=$1
fi

echo "Building $pkgdir ..."

cd $pkgdir

if [ ! -z "$doretry" ]; then
    wf-makepkg -s --noconfirm || true
fi
wf-makepkg -s --noconfirm
