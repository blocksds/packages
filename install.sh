#!/bin/bash

set -e

if [ -z "$1" ]
then
    echo "Specify a package to install!"
    exit 1
else
    pkgdir=$1
fi

pkgfile=`ls "${pkgdir}" | grep ".pkg.tar.xz"`

echo "Installing ${pkgdir}/${pkgfile}"
wf-pacman -U --noconfirm "${pkgdir}/${pkgfile}" --overwrite '*'
