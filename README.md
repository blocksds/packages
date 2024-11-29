# BlocksDS Packages

This repo contains build files for all the libraries shipped with BLocksDS. They
are automatically build and hosted as a pacman repository using Github actions.
They can be downloaded with the ``wf-pacman`` command.

## Installing libraries from the repository

Installing libraries from this repository can be done with ``wf-pacman`` like so:

```
wf-pacman -Sy library
```

Replace library with the library which should be installed.

An overview of libaries available can be viewed with:

```
wf-pacman -Ss
```

Installing default packages (SDK and documentation) can be done with:

```
wf-pacman -Sy
wf-pacman -S blocksds-default
```

You can install the additional packages (non-core libraries) with:
```
wf-pacman -S blocksds-extra
```

To update the packages, run:

```
wf-pacman -Syu
```

## Building individual libraries

Building a single package from a clone of this repository can be useful if you
wish to modify it in some way. It can be done by opening a terminal in the
directory of the chosen library and running the following:

```
wf-makepkg -i
```

This will build and install the package.

## Pacman Repository Hosting

The pacman repository created from this repo is published to GitHub Pages by the
GitHub Action in this repo. The repository should already be set up in
`wf-pacman` like this at the bottom of `/opt/wonderful/etc/pacman.conf`:

```
## WIP
[pspdev]
SigLevel = Optional TrustAll
Server = https://pspdev.github.io/psp-packages/
```

For forks or alternative repos, pspdev in the url in the `Server` setting should
be replaced with the owner of the fork. When forking, make sure to set the
GitHub Pages source to `GitHub Actions` in the settings of the GitHub repo.

## Contributing

Contributions to this repository are welcome. If you wish to update or add a
library look at the [contributing page](CONTRIBUTING.md).

## Special thanks

A special thanks goes out to both the contributors of PSPDEV and the VITASDK.
Most of the scripts in this repository are based on scripts written by them.

https://github.com/pspdev/psp-packages/
