# Contributing

This repository contains the build scripts for all the libraries contained in
the BlocksDS SDK. If you feel any library is missing or could use an update, let
us know or feel free to submit a pull request.

## How to add a library

A ``PKGBUILD`` file is just like you might know them from Arch Linux. Because of
this documentation for making ``PKGBUILD`` files on the Arch wiki is a great
resource for how to make ``PKGBUILD`` files. Take a look
[here](https://wiki.archlinux.org/title/Creating_packages) and
[here](https://wiki.archlinux.org/title/PKGBUILD).

Start by creating a directory for the library and a ``PKGBUILD`` file. It is
recommended to base it on another ``PKGBUILD`` in this repo which uses the same
build system as the new library. Do make sure pkgname, pkgdesc, pkgver and
license are changed, though.

Before making a pull request, make sure the library builds, installs and works.
Building and installing can be done with:

```
wf-makepkg -i
```

Also make sure to read the criteria for contributions below.

## Criteria for contributions

For new contributions to be merged, the PKGBUILDs in them should meet the following criteria:

- For new packages:
  - The following fields should be set:
    - ``pkgdesc``
    - ``license``
  - ``arch`` should be set to ``("any")`` if the package contains Nintendo DS
    code. It should be set to ``("x86_64" "aarch64")`` if it contains tools for
    the host. Otherwise (only headers, scripts, makefiles, documentation,
    configs, etc.) it should be set to ``("any")``.
  - ``sha256sums`` should be used for integrity checks of downloaded files. Git
    sources and local patches are allowed to use ``SKIP``.
  - PKGBUILDs based on versioned archive files (yourlibrary-1.2.tar.xz for
    instance) are preferred over those based on git/svn repositories.
  - The license of the library should be installed in the same folder as the
    library itself.
  - PKGBUILDs which use a git repository as source should use a specific tag or commit.
  - ``pkgname`` should not contain capital letters or special characters other than ``-``.
  - ``groups`` should be set if to ``blocksds`` unless the package conflicts with an existing package.
- For existing packages:
  - Either the ``pkgver`` or ``rel`` has been changed.
- For all PKGBUILDs:
  - Core components go in ``$pkgdir/thirdparty/blocksds/core/``.
  - Non-core components go in ``$pkgdir/thirdparty/blocksds/external/``.
