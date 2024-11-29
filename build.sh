#!/bin/bash
# build.sh by davidgfnet

# Will build the specified package or all of them if none are specified
# Example:
#  ./build.sh        # Builds all packages
#  ./build.sh sdl2   # Builds package SDL2 (and all its dependencies)
#
# It is also possible to install the packages with --install
# Example:
#  ./build.sh --install       # Builds all packages and installs them too
#  ./build.sh --install sdl2  # Builds package SDL2 + deps and installs them
#
# On GitHub actions it is required to use "--retry":
#
#  ./build.sh --install --retry

set -e

recursive_args=""

doinstall=""
if [ "$1" == "--install" ]; then
  doinstall="true"
  recursive_args="$recursive_args --install"
  shift
fi

doretry=""
if [ "$1" == "--retry" ]; then
  doretry="true"
  recursive_args="$recursive_args --retry"
  shift
fi

if [ -z "$1" ]
then
  # By default build them all
  PKG_LIST=$(find . -name "PKGBUILD" -exec sh -c 'echo $(basename $(dirname $0))' {} \;)
else
  PKG_LIST=$1
fi

for pkgdir in $PKG_LIST;
do

  if [[ ! -f "$pkgdir/PKGBUILD" ]]; then
    echo "Package $pkgdir does not exist!"
    continue
  fi

  for pkgdep in $(bash -c "./parse_pkgbuild.sh $pkgdir/PKGBUILD depends"); do
    ./build.sh $recursive_args "$pkgdep"
  done

  pkgfile=$(bash -c "./parse_pkgbuild.sh $pkgdir/PKGBUILD pkgoutput")

  if [[ ! -f "${pkgdir}/${pkgfile}" ]]; then
    echo "Building $pkgdir ..."
    cd $pkgdir
    if [ ! -z "$doretry" ]; then
      wf-makepkg -sf --noconfirm || true
    fi
    wf-makepkg -sf --noconfirm
    cd ..
  fi

  if [ ! -z "$doinstall" ]; then
    echo "Installing $pkgdir"
    wf-pacman -U --noconfirm "${pkgdir}/${pkgfile}" --overwrite '*'
  fi

done
