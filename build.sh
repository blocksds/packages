#!/bin/bash
# build.sh by davidgfnet

set -e

export PATH=/opt/wonderful/bin:$PATH

if [ -z "$1" ]
then
    echo "Specify a package to build!"
    exit 1
else
    pkgdir=$1
fi

echo "Building $pkgdir ..."

cd $pkgdir

wf-makepkg -f --noconfirm
