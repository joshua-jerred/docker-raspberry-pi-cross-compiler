# docker-raspberry-pi-cross-compiler
An updated version of sdt/docker-raspberry-pi-cross-compiler using build scripts from abhiTronix/raspberry-pi-cross-compilers

## Image Usage

```bash
docker run --rm -it joshuajerred/raspberry-pi-cross-compiler:64-gcc-13.3.0-bookworm /bin/bash
```

## Build the Image

```bash
bash ./install_prereqs.sh
make install-prerequisites
make build-compiler
make build-image
```
