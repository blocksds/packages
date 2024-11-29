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

set -e

doinstall=""
if [ "$1" == "--install" ]; then
  doinstall="true"
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
    if [ -z $doinstall ]; then
      ./build.sh "$pkgdep"
    else
      ./build.sh --install "$pkgdep"
    fi
  done

  pkgfile=$(bash -c "./parse_pkgbuild.sh $pkgdir/PKGBUILD pkgoutput")

  if [[ ! -f "${pkgdir}/${pkgfile}" ]]; then
    echo "Building $pkgdir ..."
    (cd $pkgdir && wf-makepkg -s)
  fi

  if [ ! -z "$doinstall" ]; then
    echo "Installing $pkgdir"
    wf-pacman -U --noconfirm "${pkgdir}/${pkgfile}" --overwrite '*'
  fi

done
