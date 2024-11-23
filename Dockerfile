FROM debian:bookworm

RUN apt-get update && apt-get install -y \
gcc g++ gperf flex texinfo gawk gfortran texinfo \
bison build-essential openssl unzip wget git pigz libgmp-dev \
libncurses-dev autoconf automake tar figlet libmpfr-dev rsync

RUN mkdir /compiler
WORKDIR /compiler

COPY ./raspberry-pi-cross-compilers/build-scripts .

ARG gcc_version
ARG os_version

RUN chmod +x RTBuilder_64b
RUN ./RTBuilder_64b -g "${gcc_version}" -o "${os_version}"

SHELL ["/bin/bash", "-c"]