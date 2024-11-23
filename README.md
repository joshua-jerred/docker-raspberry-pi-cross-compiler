# docker-raspberry-pi-cross-compiler
An updated version of
[sdt/docker-raspberry-pi-cross-compiler](https://github.com/sdt/docker-raspberry-pi-cross-compiler)
using build scripts from
[abhiTronix/raspberry-pi-cross-compilers](https://github.com/abhiTronix/raspberry-pi-cross-compilers).

## Description

This is a simple Docker image that contains a x86_64 to aarch64 cross compiler
for the Raspberry Pi.

Currently, it only contains the compiler and not the sysroot. This means that
you will need to follow [this guide to finish the setup](https://github.com/abhiTronix/raspberry-pi-cross-compilers/wiki/Cross-Compiler-CMake-Usage-Guide-with-rsynced-Raspberry-Pi-64-bit-OS#cross-compiler-cmake-usage-guide-with-rsynced-raspberry-pi-64-bit-os).

## Docker Image

On Docker Hub: [joshuajerred/raspberry-pi-cross-compiler](https://hub.docker.com/r/joshuajerred/raspberry-pi-cross-compiler)

### Tags

- `64-gcc-12.2.0-bookworm`

## Image Usage

```bash
docker run --rm -it joshuajerred/raspberry-pi-cross-compiler:64-gcc-12.2.0-bookworm /bin/bash

aarch64-linux-gnu-gcc ...
aarch64-linux-gnu-g++ ...
# etc.
```

## Build the Image

```bash
bash ./install_prereqs.sh
make install-prerequisites
make build-compiler
make build-image
```
